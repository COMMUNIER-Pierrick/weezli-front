

import 'Address.dart';
import 'PackageSize.dart';
import 'Transportation.dart';

class Package {
  int? id;
  Address addressDeparture;
  Address addressArrival;
  DateTime? datetimeDeparture;
  DateTime? dateTimeArrival;
  num kgAvailable;
  Transportation? transportation;
  String description;
  List<PackageSize> size; // Faire liste

  Package({
    this.id,
    required this.addressDeparture,
    required this.addressArrival,
    this.datetimeDeparture,
    this.dateTimeArrival,
    required this.kgAvailable,
    this.transportation,
    required this.description,
    required this.size,
    price,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"] as int,
        addressDeparture: Address.fromJson(json["addressDeparture"]),
        addressArrival: Address.fromJson(json["addressArrival"]),
        datetimeDeparture: (json['datetimeDeparture'] != null) ? DateTime.parse(json['datetimeDeparture']): null,
        dateTimeArrival: (json['datetimeArrival'] != null) ? DateTime.parse(json['datetimeArrival']): null,
        kgAvailable: json["kgAvailable"],
        transportation: (json["transport"] != null ) ? Transportation.fromJson(json["transport"]) : null,
        description: json["description"],
        size: SizesList.fromJson(json["sizes"]).sizes,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressDeparture": addressDeparture,
        "addressArrival": addressArrival,
        "datetime_departure": datetimeDeparture,
        "datetime_arrival": dateTimeArrival,
        "kgAvailable": kgAvailable,
        "idTransport": transportation,
        "description": description,
        "sizes": size,
      };
}
