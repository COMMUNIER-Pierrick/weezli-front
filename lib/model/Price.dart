
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