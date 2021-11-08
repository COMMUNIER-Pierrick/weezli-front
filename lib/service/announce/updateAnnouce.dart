import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weezli/model/Announce.dart';

Future<Response> updateAnnounce(int id, Announce announce) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var resBodyAnnounce ={};
    resBodyAnnounce["id"] = id;
    resBodyAnnounce["transact"] = 0;

    var announce = {};
    announce["Announce"] = resBodyAnnounce;

    str = encoder.convert(announce);

  }catch(e) {
  print(e);
  }

  final Response response =
  await http.put(Uri.parse("http://10.0.2.2:5000/announce/" + id.toString() + "/setTransact"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;
}