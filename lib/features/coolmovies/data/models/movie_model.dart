import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_model.g.dart';

@immutable
@JsonSerializable()
class Movie {
  final String id;
  final String imgUrl;
  final String title;
  final String releaseDate;

  const Movie(
      {required this.id,
      required this.imgUrl,
      required this.title,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
