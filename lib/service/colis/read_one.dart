import 'dart:convert';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/Package.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Order> readOneOrder(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/colis/colis/$id"),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  final Order order = Order.fromJson(json.decode(response.body)["order"][0]);
  
  return order;
}
