
import 'dart:convert';

Status StatusFromJson(String str) => Status.fromJson(json.decode(str));

String StatusToJson(Status data) => json.encode(data.toJson());

class Status {
  Status ({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
