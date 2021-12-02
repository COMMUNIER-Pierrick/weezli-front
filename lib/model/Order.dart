import 'dart:convert';

import 'Announce.dart';
import 'Opinion.dart';
import 'Status.dart';


class Order {
  Order({
    this.id,
    required this.announce,
    required this.status,
    this.validationCode,
    required this.dateOrder,
    this.qrCode,
    required this.opinions,
  });

  int? id;
  Announce announce;
  Status status;
  int? validationCode;
  DateTime dateOrder;
  String? qrCode;
  List<Opinion> opinions;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json["id"],
      validationCode: json ["codeValidated"],
      status: Status.fromJson(json["id_status"]),
      announce: Announce.fromJson(json["id_announce"]),
      dateOrder: DateTime.parse(json["dateOrder"]),
      qrCode: json ["qrCode"],
      opinions: OpinionsList.fromJson(json["opinions"]).opinionsList,
    );
  }


  Map<String, dynamic> toJson() => {
    "id": id,
    "id_status": status,
    "validation_code": validationCode,
    "date_order" : dateOrder,
    "id_announce" : announce,
    "qr_code" : qrCode,
    "opinions" : opinions,
  };
}

// Récupère une liste dynamique à partir de la map renvoyée par le json.

class OrdersListMap {
  OrdersListMap({
    required this.list,
  });

  List <dynamic> list;

  factory OrdersListMap.fromJson(Map<String, dynamic> json) {
    return OrdersListMap(
        list: json ["Orders"]);
  }
}

// Passe d'une liste dynamique à un objet map pour créer une annonce.

class OrdersListDynamic {
  OrdersListDynamic({
    required this.ordersListDynamic,
  });

  Map <String, dynamic> ordersListDynamic;

  factory OrdersListDynamic.fromJson(Map<String, dynamic> json) {
    return OrdersListDynamic(
        ordersListDynamic: json ["Order"]);
  }
}

class OrdersList {
  OrdersList({
    required this.ordersList,
  });

  List<Order> ordersList;

  //Récupère une liste dynamique pour créer annonce par annonce, puis recréer une liste d'annonces.

  factory OrdersList.fromJson(List<dynamic> parsedJson) {
    List<Order> orders = [];
    parsedJson.forEach((element) {
      var mapOrder = OrdersListDynamic.fromJson(element).ordersListDynamic;
      Order order = Order.fromJson(mapOrder);
      orders.add(order);
    });

    return new OrdersList(
        ordersList: orders
    );
  }
}
