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
  @JsonKey(name: 'movieByMovieId', fromJson: _movieTitleFromJson)
  final String movieTitle;
  final int rating;

  const Review({
    required this.id,
    required this.title,
    required this.body,
    required this.user,
    required this.movieTitle,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  static String _userFromJson(Map<String, dynamic> json) =>
      json['name'] as String;
  static String _movieTitleFromJson(Map<String, dynamic> json) =>
      json['title'] as String;
}
