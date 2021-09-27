import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/model/user.dart';

final _storage = FlutterSecureStorage();

Future<void> saveData(str) async {
  var parsed = jsonDecode(str);
  var mapUser = UserDynamic
      .fromJson(parsed)
      .userDynamic;
  print(mapUser);
  User user = User.fromJson(mapUser);
  final data = jsonDecode(str);
  await _storage.write(key: 'jwt', value: data["token"]);
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', jsonEncode(user));
}