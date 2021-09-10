import 'dart:convert';


import 'Announce.dart';
import 'Opinion.dart';
import 'Status.dart';


Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.announce,
    required this.status,
    required this.validationCode,
    required this.dateOrder,
    this.opinions,

  });

  int id;
  Announce announce;
  Status status;
  int validationCode;
  DateTime dateOrder;
  List <Opinion>? opinions;


  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    announce : json ["id_announce"],
    status : json ["id_status"],
    validationCode: json ["validation_code"],
    dateOrder: DateTime.parse(json["date_order"]),
    opinions: json ["id_opinion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_status": status,
    "validation_code": validationCode,
    "id_opinions": opinions,
    "date_order" : dateOrder,
    "id_announce" : announce,
  };
}
