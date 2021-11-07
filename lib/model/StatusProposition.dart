class StatusProposition {
  StatusProposition ({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory StatusProposition.fromJson(Map<String, dynamic> json) => StatusProposition(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
