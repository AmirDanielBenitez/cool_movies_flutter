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
  final int rating;

  const Review(
      {required this.id,
      required this.title,
      required this.body,
      required this.user,
      required this.rating});

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  static String _userFromJson(Map<String, dynamic> json) =>
      json['name'] as String;
}
