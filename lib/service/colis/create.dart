import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<int> createColis(
  String commandDate,
  String departure,
  String arrival,
  DateTime departureDate,
  String dimension,
  double poids,
  double montant,
  String deliverName,
  String validationCode,
  String description,
  bool status
) async {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String? token = await storage.read(key: "jwt");
  final Response response = await http.post(
    Uri.parse("http://10.0.2.2:5000/colis/new-colis"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      //"Authorization": "Bearer " + token!
    },
    body: jsonEncode(<String, dynamic>{
      "commandDate": commandDate,
      "departure": departure,
      "arrival": arrival,
      "departureDate": departureDate,
      "dimension": dimension,
      "poids": poids,
      "montant": montant,
      "deliverName": deliverName,
      "validationCode": validationCode,
      "description": description,
      "status": status
    }),
  );
  return response.statusCode;
}
