import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Check.dart';

Future<Check> findCheckUser(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/api/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  var parsed = jsonDecode(response.body);
  var mapCheck = ChecksListDynamic.fromJson(parsed).checksListDynamic;
  Check check = Check.fromJson(mapCheck);
  return check;
}