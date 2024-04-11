part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  MoviesLoaded({required this.movies});
}

final class MoviesNotLoaded extends MoviesState {
  final String? error;
  MoviesNotLoaded({this.error});
}
