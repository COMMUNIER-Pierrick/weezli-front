import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Order.dart';

Future<Response> createOrder(Order newOrder) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var announce = {};
    announce["id"] = newOrder.announce.id;

    var status = {};
    status["id"] = newOrder.status.id;

    var transporter = {};
    transporter["id"] = newOrder.user.id;

    var finalPrice = {};
    finalPrice["id"] = newOrder.announce.finalPrice.id;

    var resBody = {};
    resBody["announce"] = announce;
    resBody["status"] = status;
    resBody["dateOrder"] = newOrder.dateOrder.toIso8601String();
    resBody["transporter"] = transporter;
    resBody["qrCode"] = '';
    resBody["finalPrice"] = finalPrice;

    var order = {};

    order["Order"] = resBody;

    str = encoder.convert(order);
  } catch(e) {
    print(e);
  }

  final Response response =
  await http.post(Uri.parse("http://10.0.2.2:5000/order/new-order"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      },
      body: str
  );

  return response;

}