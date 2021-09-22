import 'dart:convert';

import 'dart:ffi';

import 'package:weezli/model/Formule.dart';
import 'package:weezli/model/Payment.dart';

import 'Opinion.dart';
import 'Check.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));


class User {
  User({
    this.id,
    required this.firstname,
    required this.lastname,
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
    this.choiceDateEnd
  });

  int? id;
  String firstname;
  String lastname;
  String? username;
  String? email;
  String? phone;
  int? active;
  Payment? payment;
  String? urlProfilPicture;
  Formule? formule;
  Check? check;
  List <Opinion>? opinions;
  num? moyenneAvis;
  String? password;
  DateTime? choiceDateStarted;
  DateTime? choiceDateEnd;



  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        active: json["active"],
        payment: (json['payment'] != null) ? Payment.fromJson(json["payment"]) : null,
        urlProfilPicture: json["url_profil_img"],
        formule: (json['Choice'] != null) ? Formule.fromJson(json ["Choice"]) : null,
        check: (json['Check'] != null) ? Check.fromJson(json["Check"]) : null,
        opinions: json["id_opinion"],
        moyenneAvis: json ["average_opinion"],
        password: json ["password"],
    choiceDateStarted: json ["choiceDateStarted"],
    choiceDateEnd: json ["choiceDateEnd"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": this.firstname,
        "lastname": this.lastname,
        "username": this.username,
        "password" : this.password,
        "email": this.email,

      };
}

class UserDynamic {
  UserDynamic({
    required this.userDynamic,
  });

  Map <String, dynamic> userDynamic;

  factory UserDynamic.fromJson(Map<String, dynamic> json) {
    return UserDynamic(
        userDynamic: json ["user"]);
  }
}