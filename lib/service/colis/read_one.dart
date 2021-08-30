import 'dart:convert';
import 'package:baloogo/model/colis.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Colis> readOneColis(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/colis/colis/$id"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  final Colis colis = Colis.fromJson(json.decode(response.body)["colis"][0]);
  
  return colis;
}
