import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/user.dart';

Future<int> createUser(User account) async {
  String str = "";
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {
    var resBody = {};
    resBody["firstname"] = account.firstname;
    resBody["lastname"] =  account.lastname;
    resBody["username"] =  account.username;
    resBody["password"] =  account.password;
    resBody["email"] =  account.email;
    var user = {};
    user["user"] = resBody;
    str = encoder.convert(user);
    print(str);
  } catch(e) {
    print(e);
  }
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Response response =
      await http.post(Uri.parse("http://10.0.2.2:5000/user/register"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
          },
          body: str
      );

  return response.statusCode;

}
