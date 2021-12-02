import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Opinion.dart';

Future<Response> modifyOpinion(Opinion opinion) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var newOpinion = {};
    newOpinion["id"] = opinion.id;
    newOpinion["number"] = opinion.number;
    newOpinion["comment"] = opinion.comment;
    newOpinion["idUser"] = opinion.idUser;
    newOpinion["status"] = opinion.status;
    newOpinion["idUserOpinion"] = opinion.idUserOpinion;
    newOpinion["idTypes"] = opinion.idTypes;

    var resBody = {};
    resBody["opinion"] = newOpinion;

    str = encoder.convert(resBody);

  } catch(e) {
    print(e);
  }

  final Response response =
  await http.put(Uri.parse("http://10.0.2.2:5000/opinion/update-opinion"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;

}