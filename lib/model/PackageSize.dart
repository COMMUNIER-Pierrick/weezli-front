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

class SizesListDynamic2 {
  SizesListDynamic2({
    required this.sizesListDynamic2,
  });

  List <dynamic> sizesListDynamic2;

  factory SizesListDynamic2.fromJson(Map<String, dynamic> json) {
    return SizesListDynamic2(
        sizesListDynamic2: json ["Sizes"]);
  }
}

class SizesList2 {
  final List<PackageSize> sizes;

  SizesList2({
    required this.sizes,
  });

  factory SizesList2.fromJson(List <dynamic> parsedJson) {
    List<PackageSize> sizes = [];
    parsedJson.forEach((element) {
      PackageSize size = PackageSize.fromJson(element);
      sizes.add(size);
    });

    return new SizesList2(sizes: sizes);
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


  Map<String, dynamic> toJson2(PackageSize size) =>

      {
        "size": size.toJson()
      };

}

List <dynamic> allSizesToJson(List<PackageSize> sizes) {
  List <dynamic> sizesList = [];
  for (PackageSize size in sizes) {
    var listMap = size.toJson2(size);
    sizesList.add(listMap);
  }

  return sizesList;
}
