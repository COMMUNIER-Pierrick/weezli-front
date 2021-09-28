import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weezli/model/user.dart';

Future<Response> modifyProfile(User account) async {
  String str = "";
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {
    var resBody = {};
    resBody["firstname"] = account.firstname;
    resBody["lastname"] =  account.lastname;
    resBody["phone"] =  account.phone;
    resBody["email"] =  account.email;
    resBody["url_profile_img"] = "";
    resBody ["check"] = {
      "id" : 13,
      "imgIdentity" : "picture789.png"
    };
    var user = {};
    user["User"] = resBody;
    str = encoder.convert(user);
    print(str);
    print ("http://10.0.2.2:5000/user/update-profile/" + account.id.toString());
  } catch(e) {
    print(e);
  }
  final Response response =
  await http.put(Uri.parse("http://10.0.2.2:5000/user/update-profile/" + account.id.toString()),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;

}