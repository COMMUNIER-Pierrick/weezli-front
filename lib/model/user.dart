import 'dart:convert';

import 'dart:ffi';

import 'package:weezli/model/Formule.dart';
import 'package:weezli/model/Payment.dart';

import 'Address.dart';
import 'Opinion.dart';
import 'Check.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.phone,
    this.active,
    this.payment,
    this.urlProfilPicture,
    this.formule,
    this.check,
    this.opinions,
    this.moyenneAvis,
    this.password,
    this.choiceDateStarted,
    this.choiceDateEnd,
    this.dateOfBirthday,
    this.address,
  });

  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? phone;
  int? active;
  Payment? payment;
  String? urlProfilPicture;
  Formule? formule;
  Check? check;
  List<Opinion>? opinions;
  num? moyenneAvis;
  String? password;
  DateTime? choiceDateStarted;
  DateTime? choiceDateEnd;
  DateTime? dateOfBirthday;
  Address? address;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        active: json["active"],
        payment: (json['payment'] != null)
            ? Payment.fromJson(json["payment"])
            : null,
        urlProfilPicture: json["url_profil_img"],
        formule:
            (json['choice'] != null) ? Formule.fromJson(json["choice"]) : null,
        check: (json['check'] != null) ? Check.fromJson(json["check"]) : null,
        opinions: json["id_opinion"],
        moyenneAvis: json["average_opinion"],
        password: json["password"],
        choiceDateStarted: json["choiceDateStarted"],
        choiceDateEnd: json["choiceDateEnd"],
        dateOfBirthday: (json['dateOfBirthday'] != null)
            ? DateTime.parse(json['dateOfBirthday'])
            : null,
        address: (json['address'] != null)
            ? Address.fromJson(json["address"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "firstname": this.firstname,
        "lastname": this.lastname,
        "username": this.username,
        "password": this.password,
        "email": this.email,
        "dateOfBirthday": this.dateOfBirthday != null
            ? this.dateOfBirthday!.toIso8601String()
            : null,
      };
}

class UserDynamic {
  UserDynamic({
    required this.userDynamic,
  });

  Map<String, dynamic> userDynamic;

  factory UserDynamic.fromJson(Map<String, dynamic> json) {
    return UserDynamic(userDynamic: json["User"]);
  }
}
