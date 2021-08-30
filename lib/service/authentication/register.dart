import 'dart:convert';

import 'package:http/http.dart' as http;

Future<int> register(
  String firstname,
  String lastname,
  String username,
  String email,
  String password,
) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:5000/auth/register"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'password': password,
    }),
  );
  return response.statusCode;
}
