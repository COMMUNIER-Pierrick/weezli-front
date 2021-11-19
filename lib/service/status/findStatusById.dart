import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Status.dart';

Future<Status> findStatusById(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/status/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  var parsed = jsonDecode(response.body);
  var mapStatus = StatusListDynamic.fromJson(parsed).statusListDynamic;
  Status status = Status.fromJson(mapStatus);
  return status;

}