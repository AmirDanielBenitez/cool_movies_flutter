// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      user: Review._userFromJson(
          json['userByUserReviewerId'] as Map<String, dynamic>),
      movieData: Review._movieDataFromJson(
          json['movieByMovieId'] as Map<String, dynamic>),
      rating: json['rating'] as int,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'userByUserReviewerId': instance.user,
      'movieByMovieId': Review._movieDataToJson(instance.movieData),
      'rating': instance.rating,
    };
