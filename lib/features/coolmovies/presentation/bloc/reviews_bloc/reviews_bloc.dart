import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/features/coolmovies/data/repository/repository.dart';
import 'package:coolmovies/injection_container.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc() : super(ReviewsInitial()) {
    on<LoadReviewsByMovieEvent>(_onLoadReviewsByMovieEvent);
    on<LoadReviewsByUserEvent>(_onLoadReviewsByUserEvent);
    on<SendReviewEvent>(_onSendReviewEvent);
  }

  Future<FutureOr<void>> _onLoadReviewsByMovieEvent(
      LoadReviewsByMovieEvent event, Emitter<ReviewsState> emit) async {
    emit(ReviewsInitial());
    try {
      final List<Review> reviews = await sl<Repository>()
          .fetchAllMovieReviewsByMovie(movieId: event.movieId);
      emit(
        ReviewsLoaded(reviews: reviews),
      );
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onLoadReviewsByUserEvent(
      LoadReviewsByUserEvent event, Emitter<ReviewsState> emit) async {
    emit(ReviewsInitial());
    try {
      final List<Review> reviews =
          await sl<Repository>().fetchAllReviewsByUser(userId: event.userId);
      emit(
        ReviewsLoaded(reviews: [...reviews, ...reviews]),
      );
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onSendReviewEvent(
      SendReviewEvent event, Emitter<ReviewsState> emit) async {
    emit(ReviewsInitial());
    try {
      await sl<Repository>().sendMovieReview(
          review: event.review, movieId: event.movieId, userId: event.userId);
      final List<Review> reviews = await sl<Repository>()
          .fetchAllMovieReviewsByMovie(movieId: event.movieId);
      emit(
        ReviewsLoaded(reviews: reviews),
      );
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }
}
