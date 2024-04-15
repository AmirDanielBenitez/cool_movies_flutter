import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/features/coolmovies/data/repository/repository.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:meta/meta.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc() : super(ReviewsInitial()) {
    on<LoadReviewsEvent>(_onLoadReviewsEvent);
  }

  Future<FutureOr<void>> _onLoadReviewsEvent(
      LoadReviewsEvent event, Emitter<ReviewsState> emit) async {
    try {
      final List<Review> reviews = await sl<Repository>()
          .reviewsApiProvider
          .fetchAllMovieReviewsByMovie(event.movieId);
      emit(
        ReviewsLoaded(reviews: reviews),
      );
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }
}
