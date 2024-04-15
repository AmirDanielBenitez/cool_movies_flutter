import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/widgets/movie_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';

class MoviesHomePage extends StatelessWidget {
  const MoviesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coolmovies'),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SearchableList<Movie>(
                displaySortWidget: true,
                sortPredicate: (a, b) =>
                    (a.releaseDate).compareTo(b.releaseDate),
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
                inputDecoration: InputDecoration(
                  labelText: "Search Movie",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  final Movie movie;
  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/movie-detail', arguments: movie);
      },
      child: SizedBox(
        height: 150.0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Hero(
                tag: 'hero-image:${movie.id}',
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      movie.imgUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: ((context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const ShimmerBox(
                          width: 80.0,
                          height: 80.0,
                        );
                      }),
                    )),
              ),
            ),
            const SizedBox(width: 10.0),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const Text(
                    'Release Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(movie.releaseDate),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
