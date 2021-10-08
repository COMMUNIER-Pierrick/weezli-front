
import 'dart:convert';

Transportation TransportationFromJson(String str) => Transportation.fromJson(json.decode(str));

String TransportationToJson(Transportation data) => json.encode(data.toJson());

class Transportation {
  Transportation ({
    required this.id,
    this.name,
  });

  int id;
  String? name;

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class TransportationList {
  final List<Transportation> transportations;

  TransportationList({
    required this.transportations,
  });

  factory TransportationList.fromJson(List <dynamic> parsedJson) {
    List<Transportation> transportations = [];
    parsedJson.forEach((element) {
      Transportation transportation = Transportation.fromJson(element);
      transportations.add(transportation);
    });

    return new TransportationList(transportations: transportations);
  }
}

// Récupère une liste dynamique à partir de la map renvoyée par le json.

class TransportationListMap {
  TransportationListMap({
    required this.list,
  });

  List <dynamic> list;

  factory TransportationListMap.fromJson(Map<String, dynamic> json) {
    return TransportationListMap(
        list: json ["Transports"]);
  }
}