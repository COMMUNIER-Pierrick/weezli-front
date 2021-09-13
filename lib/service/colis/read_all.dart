import 'dart:convert';
import 'dart:developer';
import 'package:weezli/model/Package.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Package>> readAllPackages() async {
 
  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/colis/all-colis"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Package> recupAll;
  final parsed = jsonDecode(response.body);
  recupAll = parsed.map<Package>((json) => Package.fromJson(json)).toList();
  inspect(recupAll);
  return recupAll;

}
