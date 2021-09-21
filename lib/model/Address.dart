import 'dart:convert';

Address AddressFromJson(String str) => Address.fromJson(json.decode(str));

String StatusToJson(Address data) => json.encode(data.toJson());

class Address {
  Address ({
    required this.id,
    required this.name,
    required this.number,
    required this.street,
    this.additionalAddress,
    required this.zipCode,
    required this.city,
    this.country,
  });

  int id;
  String name;
  int number;
  String street;
  String? additionalAddress;
  String zipCode;
  String city;
  String? country;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    name : json ["name"],
    number: json["number"],
    street: json["street"],
    additionalAddress: json["additional_address"],
    zipCode: json["zipcode"],
    city: json["city"],
    country : json ["country"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name" : name,
    "number": number,
    "street": street,
    "additional_address": additionalAddress,
    "zipCode": zipCode,
    "city": city,
    "country" : country,
  };
}
