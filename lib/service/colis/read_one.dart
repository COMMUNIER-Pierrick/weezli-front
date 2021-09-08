import 'dart:convert';
import 'package:baloogo/model/Package.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Package> readOnePackage(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/colis/colis/$id"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  final Package package = Package.fromJson(json.decode(response.body)["package"][0]);
  
  return package;
}
