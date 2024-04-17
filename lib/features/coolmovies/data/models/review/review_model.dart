import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review_model.g.dart';

@immutable
@JsonSerializable()
class Review {
  final String id;
  final String title;
  final String body;
  @JsonKey(name: 'userByUserReviewerId', fromJson: _userFromJson)
  final String user;
  @JsonKey(
    name: 'movieByMovieId',
    fromJson: _movieDataFromJson,
    toJson: _movieDataToJson,
  )
  final MovieDataReview movieData;
  final int rating;

  const Review({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
    required this.movieData,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  static String _userFromJson(Map<String, dynamic> json) =>
      json['name'] as String;
  static MovieDataReview _movieDataFromJson(Map<String, dynamic> json) {
    return MovieDataReview(json['id'] ?? '', json['title'] ?? '');
  }

  static Map<String, dynamic> _movieDataToJson(MovieDataReview movieData) {
    return movieData.toJson();
  }
}

class MovieDataReview {
  final String id;
  final String title;
  MovieDataReview(this.id, this.title);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
    };
  }
}
