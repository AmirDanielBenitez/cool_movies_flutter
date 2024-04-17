import 'package:coolmovies/features/coolmovies/data/data_sources/local/coolmovies_database.dart';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/injection_container.dart';

Future<void> saveAllMovies(List<Movie> movies) async {
  for (Movie movie in movies) {
    await sl<CoolMoviesDatabase>().insertMovie(movie);
  }
}

Future<void> saveAllReviewsByMovie(List<Review> reviews) async {
  for (Review review in reviews) {
    await sl<CoolMoviesDatabase>().insertReview(review);
  }
}

Future<void> saveAllReviewsByUser(List<Review> reviews) async {
  for (Review review in reviews) {
    await sl<CoolMoviesDatabase>().insertReviewUser(review);
  }
}
