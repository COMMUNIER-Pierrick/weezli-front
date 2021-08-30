import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> login(
  String identifier,
  String password,
) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:5000/auth/login"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: jsonEncode(<String, String>{
      'identifier': identifier,
      'password': password,
    }),
  );
  return response;
}
