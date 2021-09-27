import 'dart:convert';

import 'package:weezli/model/user.dart';

import 'Package.dart';

Announce AnnounceFromJSon(String str) => Announce.fromJson(json.decode(str));

String AnnounceToJson(Announce data) => json.encode(data.toJson());


class Announce {
  Announce({
    required this.id,
    required this.package,
    required this.userAnnounce,
    this.views,
    required this.type,
    this.price,
    required this.transact,
    this.imgUrl,
    this.dateCreated,
  });

  int id;
  Package package;
  User? userAnnounce;
  int? views;
  int? idOrder;
  int type;
  num? price;
  int transact;
  String? imgUrl;
  DateTime? dateCreated;

  factory Announce.fromJson(Map<String, dynamic> json) {
    return Announce(
      id: json["id"],
      userAnnounce: (json['userAnnounce'] != null) ? User.fromJson(json["userAnnounce"]) : null,
      package: Package.fromJson(json["packages"]),
      views: json["views"],
      type: json["idType"],
      price: json["price"],
      transact: json["transact"],
      imgUrl: json["imgUrl"],
      dateCreated: DateTime.parse(json["dateCreated"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "packages": package,
        "userAnnounce": userAnnounce,
        "views": views,
        "price": price,
        "transact": transact,
        "idType": type,
        "imgUrl": imgUrl,
        "dateCreated": dateCreated,
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
