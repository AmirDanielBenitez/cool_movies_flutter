import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
@immutable
class Movie {
  final String id;
  final String imgUrl;
  final String title;
  final String releaseDate;
  @JsonKey(
      name: 'movieDirectorByMovieDirectorId',
      fromJson: _directorFromJson,
      toJson: _directorToJson)
  final String director;

  const Movie({
    required this.id,
    required this.imgUrl,
    required this.title,
    required this.releaseDate,
    required this.director,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  static String _directorFromJson(Map<String, dynamic> json) =>
      json['name'] as String;
  static String _directorToJson(String director) => director;
}
