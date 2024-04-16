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
            movieByMovieId {
              title
            }
          }
        }
      }
    '''),
                fetchPolicy: FetchPolicy.noCache,
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

  Future<List<Review>> fetchAllReviewsByUser(String userId) async {
    final QueryResult result =
        await sl<ValueNotifier<GraphQLClient>>().value.query(
              QueryOptions(
                document: gql('''
      {
        allMovieReviews(
          filter: {userReviewerId: {equalTo: "$userId"}}
        ) {
          nodes {
            id
            title
            body
            rating
            userByUserReviewerId {
              name
            }
            movieByMovieId {
              title
            }
          }
        }
      }
    '''),
                fetchPolicy: FetchPolicy.noCache,
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

  Future<void> sendMovieReview(
      Review review, String movieId, String userId) async {
    final QueryResult result =
        await sl<ValueNotifier<GraphQLClient>>().value.query(
              QueryOptions(
                document: gql('''
            mutation {
        createMovieReview(input: {
          movieReview: {
            title: "${review.title}",
            body: "${review.body}",
            rating: ${review.rating},
            movieId: "$movieId",
            userReviewerId: "$userId"
          }})
        {
          movieReview {
            id
            title
            body
            rating
            movieByMovieId {
              title
            }
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
  }
}
