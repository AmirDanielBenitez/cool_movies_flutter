import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:coolmovies/core/components/helper.dart';
import 'package:coolmovies/features/coolmovies/data/data_sources/local/coolmovies_database.dart';
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
    on<CheckOfflineReviewsEvent>(_onCheckOfflineReviewsEvent);
    on<SendReviewEvent>(_onSendReviewEvent);
  }

  Future<FutureOr<void>> _onLoadReviewsByMovieEvent(
      LoadReviewsByMovieEvent event, Emitter<ReviewsState> emit) async {
    emit(ReviewsInitial());
    try {
      ConnectivityResult result = await sl<Connectivity>().checkConnectivity();
      if (result == ConnectivityResult.none) {
        List<Review> reviews =
            await sl<CoolMoviesDatabase>().getReviewsForMovie(event.movieId);
        emit(
          ReviewsLoaded(reviews: reviews),
        );
      } else {
        final List<Review> reviews = await sl<Repository>()
            .fetchAllMovieReviewsByMovie(movieId: event.movieId);
        saveAllReviewsByMovie(reviews);
        emit(
          ReviewsLoaded(reviews: reviews),
        );
      }
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onLoadReviewsByUserEvent(
      LoadReviewsByUserEvent event, Emitter<ReviewsState> emit) async {
    emit(ReviewsInitial());
    try {
      ConnectivityResult result = await sl<Connectivity>().checkConnectivity();
      if (result == ConnectivityResult.none) {
        List<Review> reviews = await sl<CoolMoviesDatabase>().getReviewsUser();
        emit(
          ReviewsLoaded(reviews: reviews),
        );
      } else {
        final List<Review> reviews =
            await sl<Repository>().fetchAllReviewsByUser(userId: event.userId);
        saveAllReviewsByUser(reviews);
        emit(
          ReviewsLoaded(reviews: reviews),
        );
      }
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onCheckOfflineReviewsEvent(
      CheckOfflineReviewsEvent event, Emitter<ReviewsState> emit) async {
    try {
      ConnectivityResult result = await sl<Connectivity>().checkConnectivity();
      if (result != ConnectivityResult.none) {
        List<Review> reviewsOffline =
            await sl<CoolMoviesDatabase>().getReviewsUser();
        List<Review> toSendReviews = reviewsOffline.where((review) {
          return review.id.startsWith('offline-');
        }).toList();

        for (Review review in toSendReviews) {
          await sl<Repository>().sendMovieReview(review: review);
          await sl<CoolMoviesDatabase>().deleteReviewUser(review.id);
        }
      }
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onSendReviewEvent(
      SendReviewEvent event, Emitter<ReviewsState> emit) async {
    final ReviewsLoaded reviewsLoaded = state as ReviewsLoaded;
    emit(ReviewsInitial());
    try {
      ConnectivityResult result = await sl<Connectivity>().checkConnectivity();
      if (result == ConnectivityResult.none) {
        bool idNotFound = true;
        Random random = Random();
        int randomId = 0;

        while (idNotFound) {
          randomId = random.nextInt(1000);

          bool idExists = reviewsLoaded.reviews
              .any((review) => review.id == 'offline-$randomId');

          if (!idExists) {
            idNotFound = false;
          }
        }

        final Review review = Review(
            id: 'offline-$randomId',
            title: event.review.title,
            body: event.review.body,
            user: event.review.user,
            movieData: event.review.movieData,
            rating: event.review.rating);
        saveAllReviewsByUser([review]);
        List<Review> reviews = await sl<CoolMoviesDatabase>().getReviewsUser();
        emit(
          ReviewsLoaded(reviews: reviews),
        );
      } else {
        await sl<Repository>().sendMovieReview(review: event.review);
        final List<Review> reviews = await sl<Repository>()
            .fetchAllMovieReviewsByMovie(movieId: event.review.movieData.id);
        emit(
          ReviewsLoaded(reviews: reviews),
        );
      }
    } catch (e) {
      emit(ReviewsNotLoaded(error: e.toString()));
    }
  }
}
