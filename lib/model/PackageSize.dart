import 'dart:convert';

PackageSize SizeFromJson(String str) => PackageSize.fromJson(json.decode(str));

String SizeToJson(PackageSize data) => json.encode(data.toJson());

class SizesList {
  final List<PackageSize> sizes;

  SizesList({
    required this.sizes,
  });

  factory SizesList.fromJson(List<dynamic> parsedJson) {
    List<PackageSize> sizes = [];
    sizes = parsedJson.map((i) => PackageSize.fromJson(i)).toList();

    return new SizesList(sizes: sizes);
  }
}

class PackageSize {
  PackageSize({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory PackageSize.fromJson(Map<String, dynamic> json) => PackageSize(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
