import 'package:coolmovies/features/coolmovies/data/data_sources/remote/movies_api_provider.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie_model.dart';

class Repository {
  final MoviesApiProvider moviesApiProvider;
  Repository(this.moviesApiProvider);

  // Movies
  Future<List<Movie>> fetchAllMovies({username, password, tipoLogin}) =>
      moviesApiProvider.fetchAllMovies();
}
