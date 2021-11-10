import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/StatusProposition.dart';

Future<StatusProposition> findStatusPropositionById(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/status-proposition/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  var parsed = jsonDecode(response.body);
  var mapStatusProposition = StatusPropositionListDynamic.fromJson(parsed).statusPropositionListDynamic;
  StatusProposition statusProposition = StatusProposition.fromJson(mapStatusProposition);
  return statusProposition;

}