
import 'dart:convert';

Type TypeFromJson(String str) => Type.fromJson(json.decode(str));

String TypeToJson(Type data) => json.encode(data.toJson());

class Type {
  Type ({
    required this.id,
    this.name,
  });

  int id;
  String? name;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}