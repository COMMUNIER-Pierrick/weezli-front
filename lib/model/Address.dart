
class Address {
  Address ({
    this.id,
    this.number,
    this.street,
    this.additionalAddress,
    this.zipCode,
    required this.city,
    this.country,
    this.idInfo,
  });

  int? id;
  int? number;
  String? street;
  String? additionalAddress;
  String? zipCode;
  String city;
  String? country;
  int? idInfo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
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
