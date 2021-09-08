import 'dart:convert';

Address AddressFromJson(String str) => Address.fromJson(json.decode(str));

String StatusToJson(Address data) => json.encode(data.toJson());

class Address {
  Address ({
    required this.id,
    required this.number,
    required this.street,
    this.additionalAddress,
    required this.zipCode,
    required this.city,
  });

  int id;
  int number;
  String street;
  String? additionalAddress;
  String zipCode;
  String city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    number: json["number"],
    street: json["street"],
    additionalAddress: json["additional_address"],
    zipCode: json["zipCode"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "street": street,
    "additional_address": additionalAddress,
    "zipCode": zipCode,
    "city": city,
  };
}
