import 'package:json_annotation/json_annotation.dart';
import 'User_enums.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final Gender gender;
  final Status status;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  bool get isActive => status == Status.active;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}