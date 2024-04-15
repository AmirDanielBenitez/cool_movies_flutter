// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as String,
      imgUrl: json['imgUrl'] as String,
      title: json['title'] as String,
      releaseDate: json['releaseDate'] as String,
      director: Movie._directorFromJson(
          json['movieDirectorByMovieDirectorId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'imgUrl': instance.imgUrl,
      'title': instance.title,
      'releaseDate': instance.releaseDate,
      'movieDirectorByMovieDirectorId':
          Movie._directorToJson(instance.director),
    };
