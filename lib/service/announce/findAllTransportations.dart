import 'dart:convert';
import 'dart:developer';
import 'package:weezli/model/Announce.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Transportation.dart';

Future<List<Transportation>> findAllTransportations() async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/transport/all-transports"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  var parsedJson = jsonDecode(response.body);
  var listDynamic = TransportationListMap.fromJson(parsedJson).list;
  List <Transportation> transportations = TransportationList.fromJson(listDynamic).transportations;

  return transportations;


}