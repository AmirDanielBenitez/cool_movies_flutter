import 'package:coolmovies/features/coolmovies/data/data_sources/remote/movies_api_provider.dart';
import 'package:coolmovies/features/coolmovies/data/data_sources/remote/reviews_api_provider.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';

class Repository {
  final MoviesApiProvider moviesApiProvider;
  final ReviewsApiProvider reviewsApiProvider;
  Repository(this.moviesApiProvider, this.reviewsApiProvider);

  // Movies
  Future<List<Movie>> fetchAllMovies({username, password, tipoLogin}) =>
      moviesApiProvider.fetchAllMovies();
}
