
import 'dart:convert';

import 'dart:ffi';

import 'package:weezli/model/user.dart';

import 'Price.dart';

FinalPrice PropositionPriceFromJson(String str) => FinalPrice.fromJson(json.decode(str));

String FinalPriceToJson(FinalPrice data) => json.encode(data.toJson());

class FinalPrice {
  FinalPrice ({
    required this.id,
    required this.proposition,
    required this.accept,
  });

  int id;
  double proposition;
  bool accept;

  factory FinalPrice.fromJson(Map<String, dynamic> json) => FinalPrice(
    id: json["id"],
    proposition: json["proposition"],
    accept: json["accept"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "proposition": proposition,
    "accept": accept,
  };
}