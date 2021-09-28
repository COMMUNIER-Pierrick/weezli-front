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
    parsedJson.forEach((element) {
      var sizesListDynamic = SizesListDynamic
          .fromJson(element)
          .sizesListDynamic;
      PackageSize size = PackageSize.fromJson(sizesListDynamic);
      sizes.add(size);
    });

    return new SizesList(sizes: sizes);
  }
}

class SizesListDynamic {
  SizesListDynamic({
    required this.sizesListDynamic,
  });

  Map <String, dynamic> sizesListDynamic;

  factory SizesListDynamic.fromJson(Map<String, dynamic> json) {
    return SizesListDynamic(
        sizesListDynamic: json ["size"]);
  }
}

class PackageSize {
  PackageSize({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory PackageSize.fromJson(Map<String, dynamic> json) =>
      PackageSize(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
      };

}


