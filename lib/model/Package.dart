import 'dart:ffi';

import 'package:weezli/model/user.dart';

import 'Address.dart';
import 'Price.dart';
import 'PackageSize.dart';
import 'Transportation.dart';

class Package {
  int id;
  Address addressDeparture;
  Address addressArrival;
  DateTime datetimeDeparture;
  DateTime dateTimeArrival;
  double kgAvailable;
  Transportation transportation;
  String description;
  PackageSize size;
  Price price;

  Package({
    required this.id,
    required this.addressDeparture,
    required this.addressArrival,
    required this.datetimeDeparture,
    required this.dateTimeArrival,
    required this.kgAvailable,
    required this.transportation,
    required this.description,
    required this.size,
    required this.price,

  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
      id: json["id"] as int,
      addressDeparture: json["id_address_departure"],
      addressArrival: json["id_address_arrival"],
      datetimeDeparture: DateTime.parse(json["datetime_departure"]),
      dateTimeArrival: DateTime.parse(json["datetime_arrival"]),
      kgAvailable: json["kg_available"],
      transportation: json["idTransportation"],
      description: json["description_condition"],
      size: json ["id_size"],
      price: json ["id_price"],
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "id_address_departure" : addressDeparture,
      "id_address_arrival" : addressArrival,
      "datetime_departure" : datetimeDeparture,
      "datetime_arrival" : dateTimeArrival,
      "kg_available" : kgAvailable,
      "idTransportation" : transportation,
      "description_condition" : description,
      "id_size" : size,
      "id_price" : price,
    };
}
