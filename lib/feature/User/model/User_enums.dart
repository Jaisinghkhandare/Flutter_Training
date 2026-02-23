import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue('male')
  male,

  @JsonValue('female')
  female,
}

enum Status {
  @JsonValue('active')
  active,

  @JsonValue('inactive')
  inactive,
}