class User {
  final String name;
  final String email;
  final String gender;
  final String status;

  User({
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });
  bool get isActive => status.toLowerCase() == "active";

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender':gender,
      'status': status,
    };
  }
  // Optional: Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
    );
  }
  }