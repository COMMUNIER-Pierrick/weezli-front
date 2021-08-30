class Formules {

  int id;
  String name;
  String description;
  double price;

  Formules({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Formules.fromJson(Map<String, dynamic> json) {
    return Formules(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'].toDouble(),
    );
  }
}
