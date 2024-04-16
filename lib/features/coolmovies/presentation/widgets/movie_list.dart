import 'package:coolmovies/config/theme/app_themes.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                'assets/images/coolmovies_logo.png',
                height: 70.0,
              ).animate().fadeIn(duration: 600.ms).scale(),
              const SizedBox(height: 30.0),
              if (state is MoviesLoaded)
                Expanded(
                  child: SearchableList<Movie>(
                    builder: (list, index, movie) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: MovieTile(movie: movie),
                      );
                    },
                    initialList: state.movies,
                    filter: (p0) {
                      return state.movies
                          .where((element) => element.title.contains(p0))
                          .toList();
                    },
                    defaultSuffixIconColor: Colors.red,
                    displayClearIcon: true,
                    inputDecoration: InputDecoration(
                      labelText: "Search Movie",
                      fillColor: Colors.white,
                      labelStyle: titleTextStyle,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 55.0),
              if (state is MoviesNotLoaded)
                Expanded(
                    child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 100.0,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        state.error ??
                            'We apologize, but we were unable to load the movies at this time.',
                        textAlign: TextAlign.center,
                        style: titleTextStyle,
                      )
                    ],
                  ),
                ))
            ],
          ),
        ),
      );
    });
  }
}
