import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/user/getUserInfo.dart';

Future<http.Response> logout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  final response = http.get(
    Uri.parse("http://10.0.2.2:5000/user/logout"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
  );
  return response;
}
