part of 'reviews_bloc.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsLoaded extends ReviewsState {
  final List<Review> reviews;
  ReviewsLoaded({required this.reviews});
}

final class ReviewsNotLoaded extends ReviewsState {
  final String? error;
  ReviewsNotLoaded({this.error});
}
