import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie_model.dart';
import 'package:meta/meta.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<LoadMoviesEvent>(_onLoadMoviesEvent);
  }

  FutureOr<void> _onLoadMoviesEvent(
      LoadMoviesEvent event, Emitter<MoviesState> emit) {}
}
