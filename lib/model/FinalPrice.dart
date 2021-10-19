
import 'dart:convert';

import 'package:weezli/model/user.dart';

FinalPrice PropositionPriceFromJson(String str) => FinalPrice.fromJson(json.decode(str));

String FinalPriceToJson(FinalPrice data) => json.encode(data.toJson());

class FinalPrice {
  FinalPrice ({
    this.id,
    required this.proposition,
    required this.accept,
    required this.user,
  });

  int? id;
  num? proposition;
  int? accept;
  User user;

  factory FinalPrice.fromJson(Map<String, dynamic> json) {
    print (json["user"]);
    var fp = FinalPrice(
        id: json["id"],
        proposition: (json["proposition"] != null)
            ? json ["proposition"]
            : null,
        accept: (json["accept"] != null) ? json ["accept"] : null,
        user: User.fromJson(json["user"])
    );
    return fp;
  }

    Map<String, dynamic> toJson() => {
      "id": id,
      "proposition": proposition,
      "accept": accept,
    };
  }