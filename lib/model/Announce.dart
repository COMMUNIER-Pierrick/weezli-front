
import 'dart:convert';

import 'package:weezli/model/PropositionPrice.dart';
import 'package:weezli/model/user.dart';

import 'Package.dart';
import 'Price.dart';

Announce AnnounceFromJSon(String str) => Announce.fromJson(json.decode(str));

String AnnounceToJson(Announce data) => json.encode(data.toJson());

class Announce {
  Announce ({
    required this.id,
    required this.package,
    required this.user,
    required this.views,
    this.propositionPrice,
    this.idOrder,
    this.type,
  });

  int id;
  Package package;
  User user;
  int views;
  PropositionPrice? propositionPrice;
  int? idOrder;
  int? type;

  factory Announce.fromJson(Map<String, dynamic> json) => Announce(
    id: json["id"],
    package: json ["id_package"],
    user: json ["id_user"],
    views: json ["views"],
    propositionPrice: json ["id_proposition"],
    idOrder : json ["id_order"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_package" : package,
    "id_user" : user,
    "views" : views,
    "id_proposition" : propositionPrice,
    "id_order" : idOrder,
  };
}
