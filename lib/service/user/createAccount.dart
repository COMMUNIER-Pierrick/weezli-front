import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/user.dart';

Future<Response> createUser(User account) async {
  String str = "";
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var address = {};
    var resBodyAddress = {};
    resBodyAddress ["city"] = account.address![0].city;
    resBodyAddress["country"] = account.address![0].country;
    resBodyAddress["number"] = account.address![0].number;
    resBodyAddress["street"] = account.address![0].street;
    resBodyAddress["zipCode"] = account.address![0].zipCode;
    resBodyAddress["name"] = '';
    resBodyAddress["additionalAddress"] = '';
    resBodyAddress["idInfo"] = 3;
    address = resBodyAddress;

    var resBody = {};
    resBody["firstname"] = account.firstname;
    resBody["lastname"] =  account.lastname;
    resBody["username"] =  account.username;
    resBody["password"] =  account.password;
    resBody["email"] =  account.email;
    resBody["dateOfBirthday"] =  account.dateOfBirthday!.toIso8601String();
    resBody["address"] = address;
    var user = {};
    user["User"] = resBody;
    str = encoder.convert(user);
    print(str);
  } catch(e) {
    print(e);
  }
  final Response response =
      await http.post(Uri.parse("http://10.0.2.2:5000/user/register"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
          },
          body: str
      );

  return response;

}
