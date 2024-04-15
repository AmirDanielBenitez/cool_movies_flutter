import 'package:coolmovies/features/coolmovies/data/models/movie/movie_model.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MoviesApiProvider {
  Future<List<Movie>> fetchAllMovies() async {
    final QueryResult result =
        await sl<ValueNotifier<GraphQLClient>>().value.query(QueryOptions(
              document: gql(r"""
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
								 movieDirectorByMovieDirectorId {
                  name
								}
                title
                releaseDate
              }
            }
          }
        """),
            ));

    if (result.hasException) {
      throw result.exception.toString();
    }

    if (result.data != null) {
      Iterable movieList = result.data!["allMovies"]["nodes"];
      return movieList.map((movie) => Movie.fromJson(movie)).toList();
    }
    return [];
  }
}
