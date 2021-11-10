import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Proposition.dart';

Future<Response> createProposition(Proposition newProposition) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    // Corps de la proposition qui contient tous ses éléments

    var resBody = {};
    resBody["id_announce"] = newProposition.announce.id;
    resBody["id_user"] = newProposition.userProposition.id;
    resBody["proposition"] = newProposition.proposition;
    resBody["status_proposition"] = newProposition.statusProposition;

    var proposition = {};

    proposition["Proposition"] = resBody;

    str = encoder.convert(proposition);

  } catch(e) {
    print(e);
  }

  final Response response =
  await http.post(Uri.parse("http://10.0.2.2:5000/proposition/new-proposition"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;
}