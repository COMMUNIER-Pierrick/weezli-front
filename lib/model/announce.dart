import 'package:baloogo/model/user.dart';

class Announce {
  int id;
  String commandDate;
  String departure;
  String arrival;
  DateTime departureDate;
  DateTime arrivalDate;
  String dimension;
  String travelMode;
  double poids;
  double montant;
  int views;
  String description;
  bool status;

  Announce({
    required this.id,
    required this.commandDate,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.arrivalDate,
    required this.dimension,
    required this.travelMode,
    required this.poids,
    required this.montant,
    required this.views,
    required this.description,
    required this.status,
  });

  factory Announce.fromJson(Map<String, dynamic> json) {
    return Announce(
      id: json["id"] as int,
      commandDate: json["createdAt"] as String,
      departure: json["adress_departure"] as String,
      arrival: json["adress_arrival"] as String,
      departureDate: DateTime.parse(json["datetime_departure"]),
      arrivalDate: DateTime.parse(json["datetime_arrival"]),
      dimension: json["dimensions"] as String,
      travelMode: json["travel_mode"] as String,
      poids: json["kg_weight"].toDouble(),
      montant: json["price"].toDouble(),
      views: json["views"] as int,
      description: json["description"] as String,
      status: json["status"] == "en cours" ? true : false,
    );
  }
}