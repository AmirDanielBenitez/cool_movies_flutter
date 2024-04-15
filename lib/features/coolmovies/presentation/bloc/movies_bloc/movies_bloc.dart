// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/data/repository/repository.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<LoadMoviesEvent>(_onLoadMoviesEvent);
  }

  Future<FutureOr<void>> _onLoadMoviesEvent(
      LoadMoviesEvent event, Emitter<MoviesState> emit) async {
    try {
      final List<Movie> movies =
          await sl<Repository>().moviesApiProvider.fetchAllMovies();
      emit(
        MoviesLoaded(movies: movies),
      );
    } catch (e) {
      emit(MoviesNotLoaded(error: e.toString()));
    }
  }
}
