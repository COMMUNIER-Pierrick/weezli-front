import 'dart:convert';

import 'package:weezli/model/user.dart';

import 'Package.dart';

Announce announceFromJSon(String str) => Announce.fromJson(json.decode(str));

String announceToJson(Announce data) => json.encode(data.toJson());


class Announce {
  Announce({
    this.id,
    required this.package,
    this.views,
    required this.type,
    this.price,
    this.imgUrl,
    this.dateCreated,
    required this.userAnnounce,
  });

  int? id;
  Package package;
  int? views;
  int type;
  num? price;
  String? imgUrl;
  DateTime? dateCreated;
  User userAnnounce;

  factory Announce.fromJson(Map<String, dynamic> json) {
    return Announce(
      id: json["id"],
      package: Package.fromJson(json["packages"]),
      views: json["views"],
      type: json["idType"],
      price: (json["price"] != null) ? json ["price"] : null,
      imgUrl: json["imgUrl"],
      dateCreated: DateTime.parse(json["dateCreated"]),
      userAnnounce: User.fromJson(json["userAnnounce"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "package": package,
        "views": views,
        "price": price,
        "idType": type,
        "imgUrl": imgUrl,
        "dateCreated": dateCreated,
        "userAnnounce": userAnnounce,
      };
}

// Récupère une liste dynamique à partir de la map renvoyée par le json.

class AnnouncesListMap {
  AnnouncesListMap({
    required this.list,
  });

  List <dynamic> list;

  factory AnnouncesListMap.fromJson(Map<String, dynamic> json) {
    return AnnouncesListMap(
        list: json ["Announces"]);
  }
}

// Passe d'une liste dynamique à un objet map pour créer une annonce.

class AnnouncesListDynamic {
  AnnouncesListDynamic({
    required this.announcesListDynamic,
  });

  Map <String, dynamic> announcesListDynamic;

  factory AnnouncesListDynamic.fromJson(Map<String, dynamic> json) {
    return AnnouncesListDynamic(
        announcesListDynamic: json ["Announce"]);
  }
}

class AnnouncesList {
  AnnouncesList({
    required this.announcesList,
  });

  List<Announce> announcesList;

  //Récupère une liste dynamique pour créer annonce par annonce, puis recréer une liste d'annonces.

  factory AnnouncesList.fromJson(List<dynamic> parsedJson) {
    List<Announce> announces = [];
    parsedJson.forEach((element) {
      var mapAnnounce = AnnouncesListDynamic.fromJson(element).announcesListDynamic;
      Announce announce = Announce.fromJson(mapAnnounce);
      announces.add(announce);
    });

    return new AnnouncesList(
        announcesList: announces
    );
  }
}
