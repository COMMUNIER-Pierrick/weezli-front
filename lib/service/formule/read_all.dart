import 'dart:convert';
import 'dart:developer';
import 'package:baloogo/model/formules.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Formules>> readAllFormules() async {
 
  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/formule/all-formules"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Formules> recupAll;
  final parsed = jsonDecode(response.body);
  recupAll = parsed.map<Formules>((json) => Formules.fromJson(json)).toList();
  inspect(recupAll);
  return recupAll;

}
