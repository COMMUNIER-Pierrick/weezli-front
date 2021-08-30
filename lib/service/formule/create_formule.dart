import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<int> createFormule(
  String name,
  String description,
  double price,
) async {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String? token = await storage.read(key: "jwt");
  final Response response = await http.post(
    Uri.parse("http://10.0.2.2:5000/formule/new-formule"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      //"Authorization": "Bearer " + token!
    },
    body: jsonEncode(<String, dynamic>{
      "name": name,
      "description": description,
      "price": price
    }),
  );
  return response.statusCode;
}
