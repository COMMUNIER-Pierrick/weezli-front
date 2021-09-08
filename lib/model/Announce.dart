
import 'dart:convert';

import 'package:baloogo/model/PropositionPrice.dart';
import 'package:baloogo/model/user.dart';

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
    required this.propositionPrice
  });

  int id;
  Package package;
  User user;
  int views;
  PropositionPrice propositionPrice;

  factory Announce.fromJson(Map<String, dynamic> json) => Announce(
    id: json["id"],
    package: json ["id_package"],
    user: json ["id_user"],
    views: json ["views"],
    propositionPrice: json ["id_proposition"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_package" : package,
    "id_user" : user,
    "views" : views,
    "id_proposition" : propositionPrice
  };
}
