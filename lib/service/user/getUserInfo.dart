import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

User? getUserInfo(SharedPreferences prefs) {

  final String? userStr = prefs.getString('user');

  if (userStr != null) {
    var userMap = jsonDecode(userStr);

    User user = User.fromJson(userMap);

    return user;
  }
  else return null;
}
