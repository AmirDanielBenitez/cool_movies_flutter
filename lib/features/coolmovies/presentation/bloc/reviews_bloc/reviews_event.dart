part of 'reviews_bloc.dart';

@immutable
sealed class ReviewsEvent {}

class LoadReviewsByMovieEvent extends ReviewsEvent {
  final String movieId;
  LoadReviewsByMovieEvent({required this.movieId});
}

class LoadReviewsByUserEvent extends ReviewsEvent {
  final String userId;
  LoadReviewsByUserEvent({required this.userId});
}

class SendReviewEvent extends ReviewsEvent {
  final Review review;
  final String movieId;
  final String userId;
  SendReviewEvent({
    required this.review,
    required this.movieId,
    required this.userId,
  });
}
