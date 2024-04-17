import 'dart:async';
import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class CoolMoviesDatabase {
  late Database _database;

  Future<void> open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'cool_movies.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE movies(
          id TEXT PRIMARY KEY,
          imgUrl TEXT,
          title TEXT,
          releaseDate TEXT,
          director TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE reviews(
          id TEXT PRIMARY KEY,
          title TEXT,
          body TEXT,
          user TEXT,
          movieId TEXT,
          rating INTEGER
        )
      ''');

      await db.execute('''
        CREATE TABLE user_reviews(
          review_id TEXT PRIMARY KEY,
          title TEXT,
          body TEXT,
          user TEXT,
          movieId TEXT,
          movieTitle TEXT,
          rating INTEGER
        )
      ''');
    });
  }

  Future<void> insertMovie(Movie movie) async {
    Map<String, dynamic> movieData = {
      'id': movie.id,
      'imgUrl': movie.imgUrl,
      'title': movie.title,
      'releaseDate': movie.releaseDate,
      'director': movie.director,
    };
    await _database.insert('movies', movieData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Movie>> getMovies() async {
    List<Map<String, dynamic>> maps = await _database.query('movies');
    return List.generate(maps.length, (i) {
      return Movie(
          id: maps[i]['id'],
          imgUrl: maps[i]['imgUrl'],
          title: maps[i]['title'],
          releaseDate: maps[i]['releaseDate'],
          director: maps[i]['director']);
    });
  }

  Future<void> insertReview(Review review) async {
    Map<String, dynamic> reviewData = {
      'id': review.id,
      'title': review.title,
      'body': review.body,
      'user': review.user,
      'movieId': review.movieData.id,
      'rating': review.rating,
    };

    await _database.insert('reviews', reviewData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Review>> getReviewsForMovie(String movieId) async {
    List<Map<String, dynamic>> maps = await _database
        .query('reviews', where: 'movieId = ?', whereArgs: [movieId]);
    return List.generate(maps.length, (i) {
      return Review(
          id: maps[i]['id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
          user: maps[i]['user'],
          movieData: MovieDataReview('', ''),
          rating: maps[i]['rating']);
    });
  }

  Future<void> insertReviewUser(Review review) async {
    Map<String, dynamic> reviewData = {
      'review_id': review.id,
      'title': review.title,
      'body': review.body,
      'user': review.user,
      'movieId': review.movieData.id,
      'movieTitle': review.movieData.title,
      'rating': review.rating,
    };

    await _database.insert('user_reviews', reviewData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Review>> getReviewsUser() async {
    List<Map<String, dynamic>> maps = await _database.query('user_reviews');
    return List.generate(maps.length, (i) {
      return Review(
          id: maps[i]['review_id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
          user: maps[i]['user'],
          movieData: MovieDataReview(maps[i]['movieId'], maps[i]['movieTitle']),
          rating: maps[i]['rating']);
    });
  }

  Future<void> deleteReviewUser(String id) async {
    List<Map<String, dynamic>> maps = await _database.query('user_reviews');
    await _database.delete(
      'user_reviews',
      where: 'review_id = ?',
      whereArgs: [id],
    );
  }
}
