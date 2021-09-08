import 'dart:convert';

import 'dart:ffi';

import 'package:baloogo/model/Formule.dart';
import 'package:baloogo/model/RIB.dart';

import 'Opinion.dart';
import 'Check.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phone,
    required this.active,
    required this.rib,
    required this.urlProfilPicture,
    required this.formule,
    required this.check,
    this.opinions,
    this.moyenneAvis,
  });

  int id;
  String firstname;
  String lastname;
  String username;
  String email;
  String phone;
  bool active;
  RIB rib;
  String urlProfilPicture;
  Formule formule;
  Check check;
  List <Opinion>? opinions;
  double? moyenneAvis;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        active: json["active"],
        rib: json["idRib"],
        urlProfilPicture: json["url_profil_picture"],
        formule: json ["idFormule"],
        check: json["id_check"],
        opinions: json["id_opinion"],
        moyenneAvis: json ["moyenneAvis"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "phone": phone,
        "active": active,
        "idRib": rib,
        "url_profil_picture": urlProfilPicture,
        "idFormule": formule,
        "id_check": check,
        "id_opinions" : opinions,
        "moyenneAvis" : moyenneAvis,
      };
}
