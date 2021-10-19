import 'dart:convert';

import 'package:http/http.dart';
import 'package:weezli/model/Order.dart';
import 'package:http/http.dart' as http;

Future<Order> findById(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/order/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  var parsed = jsonDecode(response.body);
  var mapOrder = OrdersListDynamic.fromJson(parsed).ordersListDynamic;
  Order order = Order.fromJson(mapOrder);
  return order;

}