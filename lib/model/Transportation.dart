
import 'dart:convert';

Transportation TransportationFromJson(String str) => Transportation.fromJson(json.decode(str));

String TransportationToJson(Transportation data) => json.encode(data.toJson());

class Transportation {
  Transportation ({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}