
import 'dart:convert';

import 'dart:ffi';

import 'package:baloogo/model/user.dart';

import 'Price.dart';

PropositionPrice PropositionPriceFromJson(String str) => PropositionPrice.fromJson(json.decode(str));

String PropositionPriceToJson(PropositionPrice data) => json.encode(data.toJson());

class PropositionPrice {
  PropositionPrice ({
    required this.id,
    required this.proposition,
    required this.accept,
    required this.sender,
  });

  int id;
  double proposition;
  bool accept;
  User sender;

  factory PropositionPrice.fromJson(Map<String, dynamic> json) => PropositionPrice(
    id: json["id"],
    proposition: json["proposition"],
    accept: json["accept"],
    sender: json["id_sender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "proposition": proposition,
    "accept": accept,
    "id_sender": sender,
  };
}