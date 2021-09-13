import 'dart:convert';

import 'package:weezli/model/user.dart';
import 'package:weezli/service/user/me.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<int> createAnnounce(
  String adressDeparture,
  String adressArrival,
  String datetimeDeparture,
  String datetimeArrival,
  double kgAvailable,
  double kgPrice,
  double kgWanted,
  String listObjects,
  String descriptionConditions,
  String type,
) async {
  final User user = await me();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String? token = await storage.read(key: "jwt");
  final Response response = await http.post(
    Uri.parse("http://10.0.2.2:5000/announces/new-announce"), 
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Authorization": "Bearer " + token!
    },
    body: jsonEncode(<String, dynamic>{
      "adress_departure": adressDeparture,
      "adress_arrival": adressArrival,
      "datetime_departure": datetimeDeparture,
      "datetime_arrival": datetimeArrival,
      "kg_available": kgAvailable,
      "kg_price": kgPrice,
      "kg_wanted": kgWanted,
      "list_objects": listObjects,
      "description_conditions": descriptionConditions,
      "userId": user.id,
      "type": type
    }),
  );
  return response.statusCode;
}
