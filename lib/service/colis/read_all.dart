import 'dart:convert';
import 'dart:developer';
import 'package:baloogo/model/colis.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Colis>> readAllColis() async {
 
  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/colis/all-colis"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Colis> recupAll;
  final parsed = jsonDecode(response.body);
  recupAll = parsed.map<Colis>((json) => Colis.fromJson(json)).toList();
  inspect(recupAll);
  return recupAll;

}
