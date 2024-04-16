import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@immutable
@JsonSerializable()
class User {
  final String id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
