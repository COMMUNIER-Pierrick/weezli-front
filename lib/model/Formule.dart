class Formule {

  int id;
  String name;
  String? description;
  num? price;

  Formule({
    required this.id,
    required this.name,
    this.description,
    this.price,
  });

  factory Formule.fromJson(Map<String, dynamic> json) {
    return Formule(
      id: json['id'] as int,
      name: json['name'] as String,
      description: (json['description'] != null) ? json["description"] : null,
      price: json['price'],
    );
  }
}
