import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weezli/model/user.dart';

Future<http.Response> login(User login)
async {
  String str = "";
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {
    var resBody = {};
    resBody["password"] =  login.password;
    resBody["email"] =  login.email;
    var user = {};
    user["user"] = resBody;
    str = encoder.convert(user);
  } catch(e) {
    print(e);
  }
  final response = await http.post(
    Uri.parse("http://10.0.2.2:5000/user/login"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: str,
  );
  return response;
}
