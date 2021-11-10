import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Order.dart';

Future<Response> createOrder(Order order) async {
  var str;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    // Corps de l'order qui contient tous ses éléments

    var newOrder = {};
    newOrder["codeValidated"] = order.validationCode;
    newOrder["status"] = order.status.id;
    newOrder["announce"] = order.announce.id;
    newOrder["dateOrder"] = order.dateOrder.toIso8601String();

    var resBody = {};
    resBody["Order"] = newOrder;

    str = encoder.convert(resBody);

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