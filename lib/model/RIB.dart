
import 'dart:convert';
import 'dart:ffi';

RIB RIBFromJson(String str) => RIB.fromJson(json.decode(str));

String RIBToJson(RIB data) => json.encode(data.toJson());

class RIB {
  RIB ({
    required this.id,
    required this.name,
    required this.IBAN,
  });

  int id;
  String name;
  String IBAN;

  factory RIB.fromJson(Map<String, dynamic> json) => RIB(
    id: json["id"],
    name: json["name"],
    IBAN: json["IBAN"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "IBAN": IBAN,
  };
}
