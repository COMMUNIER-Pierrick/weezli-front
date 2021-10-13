
import 'dart:convert';

Price PriceFromJson(String str) => Price.fromJson(json.decode(str));

String PriceToJson(Price data) => json.encode(data.toJson());

class Price {
  Price ({
    required this.id,
    required this.kgPrice,
  });

  int id;
  double kgPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    id: json["id"],
    kgPrice: json["kg_Price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kg_Price": kgPrice,
  };
}