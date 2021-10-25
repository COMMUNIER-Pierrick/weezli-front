import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/FinalPrice.dart';

Future<Response> updateFinalPrice(int id, FinalPrice finalPrice) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var resBodyfinalPrice = {};
    resBodyfinalPrice["id"] = finalPrice.id;
    resBodyfinalPrice["accept"] = 0;
    resBodyfinalPrice["user"] = finalPrice.user;
    resBodyfinalPrice["proposition"] = finalPrice.proposition;


    var resBody = {};
    resBody["id"] = id;
    resBody["finalPrice"] = resBodyfinalPrice;
    resBody["transact"] = 1;

    var announce = {};
    announce["Announce"] = resBody;

    str = encoder.convert(announce);

  } catch(e) {
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