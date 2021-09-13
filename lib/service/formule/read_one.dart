import 'dart:convert';
import 'package:weezli/model/Formule.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Formule> readOneFormule(int id) async {
  print("object");
  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/formule/formule/$id"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  final Formule formule = Formule.fromJson(json.decode(response.body));
  return formule;
}
