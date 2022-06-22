import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/model/user.dart';

User? getUserInfo(SharedPreferences prefs) {

  final String? userStr = prefs.getString('user');
  if (userStr != null) {
    var userMap = jsonDecode(userStr);
    User user = User.fromJson(userMap);
    return user;
  }
  else return null;
}
