import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Proposition.dart';

Future<List<Proposition>> findAllByUser(id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/proposition/all-proposition-by-user/"  + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  List<Proposition> propositionsList = [];
  final parsed = jsonDecode(response.body);

  var propositionsListMap = PropositionsListMap.fromJson(parsed).list;
  propositionsList = PropositionsList.fromJson(propositionsListMap).propositionsList;
  return propositionsList;

}