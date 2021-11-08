import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Proposition.dart';

Future<Response> updateProposition(Proposition proposition) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var resBodyProposition = {};
    resBodyProposition["id"] = proposition.announce;
    resBodyProposition["accept"] = proposition.userProposition;
    resBodyProposition["user"] = proposition.proposition;
    resBodyProposition["proposition"] = proposition.statusProposition;

    var newProposition = {};
    newProposition["Proposition"] = resBodyProposition;

    str = encoder.convert(newProposition);

  } catch(e) {
    print(e);
  }

  final Response response =
  await http.put(Uri.parse("http://10.0.2.2:5000/proposition/update-proposition"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;

}