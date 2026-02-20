import 'User_enums.dart';

class User {
  final String name;
  final String email;
  final Gender gender;
  final Status status;

  User({
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  bool get isActive => status == Status.active;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender.name, // converts enum → string
      'status': status.name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      gender: Gender.values.firstWhere(
            (e) => e.name == json['gender'],
      ),
      status: Status.values.firstWhere(
            (e) => e.name == json['status'],
      ),
    );
  }
}