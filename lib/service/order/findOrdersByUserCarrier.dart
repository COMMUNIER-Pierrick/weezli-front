import 'dart:convert';
import 'package:weezli/model/Order.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Order>> findOrdersByUserCarrier(int? id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/order/deliveries/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Order> ordersList = [];
  final parsed = jsonDecode(response.body);
  var ordersListMap = OrdersListMap.fromJson(parsed).list;
  ordersList = OrdersList.fromJson(ordersListMap).ordersList;
  return ordersList;

}