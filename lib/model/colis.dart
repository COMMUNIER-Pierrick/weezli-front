import 'package:baloogo/model/user.dart';

class Colis {
  int id;
  String commandDate;
  String departure;
  String arrival;
  DateTime departureDate;
  String dimension;
  double poids;
  double montant;
  String deliverName;
  String validationCode;
  String description;
  bool status;

  Colis({
    required this.id,
    required this.commandDate,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.dimension,
    required this.poids,
    required this.montant,
    required this.deliverName,
    required this.validationCode,
    required this.description,
    required this.status,
  });

  factory Colis.fromJson(Map<String, dynamic> json) {
    return Colis(
      id: json["id"] as int,
      commandDate: json["createdAt"] as String,
      departure: json["adress_departure"] as String,
      arrival: json["adress_arrival"] as String,
      departureDate: DateTime.parse(json["datetime_departure"]),
      dimension: json["dimensions"] as String,
      poids: json["kg_weight"].toDouble(),
      montant: json["price"].toDouble(),
      deliverName: json["userId"].toString(),
      validationCode: json["validation_code"].toString(),
      description: json["description"] as String,
      status: json["status"] == "en cours" ? true : false,
    );
  }
}
