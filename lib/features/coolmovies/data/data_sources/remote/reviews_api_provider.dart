import 'package:coolmovies/features/coolmovies/data/models/review/review_model.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReviewsApiProvider {
  Future<List<Review>> fetchAllMovieReviewsByMovie(String movieId) async {
    final QueryResult result =
        await sl<ValueNotifier<GraphQLClient>>().value.query(
              QueryOptions(
                document: gql('''
      {
        allMovieReviews(
          filter: {movieId: {equalTo: "$movieId"}}
        ) {
          nodes {
            id
            title
            body
            rating
            userByUserReviewerId {
              name
            }
          }
        }
      }
    '''),
              ),
            );

    if (result.hasException) {
      throw result.exception.toString();
    }

    if (result.data != null) {
      Iterable reviewList = result.data!["allMovieReviews"]["nodes"];
      return reviewList.map((movie) => Review.fromJson(movie)).toList();
    }
    return [];
  }
}
