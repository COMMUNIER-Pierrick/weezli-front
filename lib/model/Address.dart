import 'dart:convert';

Address AddressFromJson(String str) => Address.fromJson(json.decode(str));

String StatusToJson(Address data) => json.encode(data.toJson());

class Address {
  Address ({
    this.id,
    this.name,
    this.number,
    this.street,
    this.additionalAddress,
    this.zipCode,
    required this.city,
    this.country,
    this.idInfo,
  });

  int? id;
  String? name;
  int? number;
  String? street;
  String? additionalAddress;
  String? zipCode;
  String city;
  String? country;
  int? idInfo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    name : json ["name"],
    number: json["number"],
    street: json["street"],
    additionalAddress: json["additional_address"],
    zipCode: json["zipCode"],
    city: json["city"],
    country : json ["country"],
    idInfo: json["idInfo"]
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

class AddressList {
  final List<Address> addresses;

  AddressList({
    required this.addresses,
  });

  factory AddressList.fromJson(List<dynamic> parsedJson) {
    List<Address> addresses = [];
    parsedJson.forEach((element) {
      Address address = Address.fromJson(element);
      addresses.add(address);
    }
    );
    return new AddressList(addresses: addresses);
  }
}
