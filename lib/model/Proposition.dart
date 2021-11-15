import 'dart:convert';

import 'package:weezli/model/user.dart';

import 'Announce.dart';
import 'StatusProposition.dart';

Proposition propositionFromJSon(String str) => Proposition.fromJson(json.decode(str));

String propositionToJson(Proposition data) => json.encode(data.toJson());


class Proposition {
  Proposition({
    required this.announce,
    required this.userProposition,
    this.proposition,
    required this.statusProposition,
  });

  Announce announce;
  User userProposition;
  num? proposition;
  StatusProposition statusProposition;

  factory Proposition.fromJson(Map<String, dynamic> json) {
    return Proposition(
        announce: Announce.fromJson(json["announce"]),
        userProposition: User.fromJson(json["user"]),
        proposition: json["proposition"],
        statusProposition: StatusProposition.fromJson(json["status_proposition"])
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "announce": announce,
        "userProposition": userProposition,
        "proposition": proposition,
        "statusProposition": statusProposition,
      };
}

// Récupère une liste dynamique à partir de la map renvoyée par le json.

class PropositionsListMap {
  PropositionsListMap({
    required this.list,
  });

  List <dynamic> list;

  factory PropositionsListMap.fromJson(Map<String, dynamic> json) {
    return PropositionsListMap(
        list: json ["Propositions"]);
  }
}

// Passe d'une liste dynamique à un objet map pour créer une proposition.

class PropositionsListDynamic {
  PropositionsListDynamic({
    required this.propositionsListDynamic,
  });

  Map <String, dynamic> propositionsListDynamic;

  factory PropositionsListDynamic.fromJson(Map<String, dynamic> json) {
    return PropositionsListDynamic(
        propositionsListDynamic: json ["Proposition"]);
  }
}

class PropositionsList {
  PropositionsList({
    required this.propositionsList,
  });

  List<Proposition> propositionsList;

  //Récupère une liste dynamique pour créer proposition par proposition, puis recréer une liste de propositions.

  factory PropositionsList.fromJson(List<dynamic> parsedJson) {
    List<Proposition> propositions = [];
    parsedJson.forEach((element) {
      var mapProposition = PropositionsListDynamic.fromJson(element).propositionsListDynamic;
      Proposition proposition = Proposition.fromJson(mapProposition);
      propositions.add(proposition);
    });

    return new PropositionsList(
        propositionsList: propositions
    );
  }
}