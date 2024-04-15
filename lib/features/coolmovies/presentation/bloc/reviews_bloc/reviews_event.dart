part of 'reviews_bloc.dart';

@immutable
sealed class ReviewsEvent {}

class LoadReviewsEvent extends ReviewsEvent {
  final String movieId;
  LoadReviewsEvent({required this.movieId});
}
