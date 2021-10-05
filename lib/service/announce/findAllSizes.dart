import 'dart:convert';
import 'dart:developer';
import 'package:weezli/model/Announce.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Transportation.dart';

Future<List<PackageSize>> findAllSizes() async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/size/all-sizes"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List <PackageSize> sizes = [];
  var parsedJson = jsonDecode(response.body);
  var list = SizesListDynamic2.fromJson(parsedJson).sizesListDynamic2;
  sizes = SizesList2.fromJson(list).sizes;

  return sizes;


}