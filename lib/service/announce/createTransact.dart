import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Announce.dart';

Future<Response> createTransact(Announce currentAnnounce) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var resBodyfinalPrice = {};
    resBodyfinalPrice["id"] = currentAnnounce.finalPrice.id;
    resBodyfinalPrice["accept"] = 1;
    resBodyfinalPrice["user"] = currentAnnounce.userAnnounce;
    resBodyfinalPrice["proposition"] = currentAnnounce.price!;


    var resBody = {};
    resBody["id"] = currentAnnounce.id;
    resBody["transact"] = 1;
    resBody["finalPrice"] = resBodyfinalPrice;

    var announce = {};
    announce["Announce"] = resBody;

    str = encoder.convert(announce);
    print (str);
  } catch(e) {
    print(e);
  }

  final Response response =
  await http.put(Uri.parse("http://10.0.2.2:5000/announce/" + currentAnnounce.id.toString() + "/setTransact"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;

}