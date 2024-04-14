part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class LoadMoviesEvent extends MoviesEvent {}
