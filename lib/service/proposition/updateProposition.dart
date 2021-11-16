import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Proposition.dart';

Future<Response> updateProposition(Proposition proposition) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var newProposition = {};
    newProposition["id_announce"] = proposition.announce.id;
    newProposition["id_user"] = proposition.userProposition.id;
    newProposition["proposition"] = proposition.proposition;
    newProposition["status_proposition"] = proposition.statusProposition;

    var resBody = {};
    resBody["Proposition"] = newProposition;

    str = encoder.convert(resBody);

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