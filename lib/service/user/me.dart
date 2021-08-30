import 'package:baloogo/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<User> me() async {
  final _storage = FlutterSecureStorage();
  final String? token = await _storage.read(key: 'jwt');

  final response = await http.get(
    Uri.parse("http://10.0.2.2:5000/user/me"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  final User user = userFromJson(response.body);
  return user;
}

