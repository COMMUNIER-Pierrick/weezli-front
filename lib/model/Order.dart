import 'dart:convert';

import 'dart:ffi';

import 'package:baloogo/model/PropositionPrice.dart';
import 'package:baloogo/model/user.dart';

import 'Announce.dart';
import 'Opinion.dart';
import 'Package.dart';
import 'Price.dart';
import 'Status.dart';


Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.announce,
    required this.status,
    required this.validationCode,
    this.opinions,

  });

  int id;
  Announce announce;
  Status status;
  int validationCode;
  List <Opinion>? opinions;


  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    announce : json ["id_announce"],
    status : json ["id_status"],
    validationCode: json ["validation_code"],
    opinions: json ["id_opinion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_status": status,
    "validation_code": validationCode,
    "id_opinions": opinions,
    "id_announce" : announce,
  };
}