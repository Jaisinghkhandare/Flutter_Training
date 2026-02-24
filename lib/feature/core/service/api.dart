import 'dart:convert';

//import 'package:exercise01/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../User/model/user_model.dart';
//mockito
//mocktail
//add dependency test and flutter_test
//given when then
//assert --expect()
//stubbing--when
//
class ApiService {
  final http.Client httpClient;

  const ApiService({required this.httpClient});

  Future<List<User>?> apiCall() async {
    final response = await http.get(
      Uri.parse('https://gorest.co.in/public/v2/users'),
      headers: {
        "Authorization": "Bearer 38b87c29678a9e384ea3015f1bfc502b74c27d37b1b9e15c22af5d2df59f6592",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => User.fromJson(e)).toList();
    }
    return null;
  }
  Future<void> deleteUser(int userId) async {
    final url = Uri.parse('https://gorest.co.in/public/v2/users/$userId');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer 38b87c29678a9e384ea3015f1bfc502b74c27d37b1b9e15c22af5d2df59f6592',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 204) {
      throw Exception("Failed to delete user: ${response.body}");
    }
  }




  Future<User> createUser(User user) async {
    final response = await httpClient.post(
      Uri.parse('https://gorest.co.in/public/v2/users'),
      headers: {
        "Authorization": "Bearer 38b87c29678a9e384ea3015f1bfc502b74c27d37b1b9e15c22af5d2df59f6592",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": user.name,
        "email": user.email,
        "gender": user.gender.name,
        "status": user.status.name,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
