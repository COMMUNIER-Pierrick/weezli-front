import 'dart:convert';
import 'dart:developer';
import 'package:weezli/model/Formule.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Formule>> readAllFormules() async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/formule/all-formules"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Formule> recupAll;
  final parsed = jsonDecode(response.body);
  recupAll = parsed.map<Formule>((json) => Formule.fromJson(json)).toList();
  inspect(recupAll);
  return recupAll;

}
