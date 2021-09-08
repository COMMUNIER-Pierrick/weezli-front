class Formule {

  int id;
  String name;
  String description;
  double price;

  Formule({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Formule.fromJson(Map<String, dynamic> json) {
    return Formule(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'].toDouble(),
    );
  }
}
