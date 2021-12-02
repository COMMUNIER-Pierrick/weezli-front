import 'dart:convert';

Opinion opinionFromJSon(String str) => Opinion.fromJson(json.decode(str));

String opinionToJson(Opinion data) => json.encode(data.toJson());

class Opinion {
  Opinion({
    required this.id,
    required this.number,
    required this.comment,
    required this.idUser,
    required this.status,
    required this.idUserOpinion,
    required this.idTypes,
  });

  int id;
  dynamic number;
  String comment;
  int idUser;
  String status;
  int idUserOpinion;
  int idTypes;

  factory Opinion.fromJson(Map<String, dynamic> json) => Opinion(
      id: json["id"],
      number: json["number"],
      comment: json["comment"],
      idUser: json["idUser"],
      status: json["status"],
      idUserOpinion: json["idUserOpinion"],
      idTypes: json["idTypes"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "comment": comment,
    "idUser": idUser,
    "status": status,
    "id_user": idUserOpinion,
    "idTypes": idTypes,
  };
}

// Récupère une liste dynamique à partir de la map renvoyée par le json.

class OpinionsListMap {
  OpinionsListMap({
    required this.list,
  });

  List <dynamic> list;

  factory OpinionsListMap.fromJson(Map<String, dynamic> json) {
    return OpinionsListMap(
        list: json ["Opinions"]);
  }
}

// Passe d'une liste dynamique à un objet map pour créer une opinion.

class OpinionsListDynamic {
  OpinionsListDynamic({
    required this.opinionsListDynamic,
  });

  Map <String, dynamic> opinionsListDynamic;

  factory OpinionsListDynamic.fromJson(Map<String, dynamic> json) {
    return OpinionsListDynamic(
        opinionsListDynamic: json ["Opinion"]);
  }
}

class OpinionsList {

  OpinionsList({
    required this.opinionsList,
  });

  List<Opinion> opinionsList;

  //Récupère une liste dynamique pour créer opinion par opinion, puis recréer une liste d'opinions.

  factory OpinionsList.fromJson(List<dynamic> parsedJson) {
    List<Opinion> opinions = [];
    parsedJson.forEach((element) {
      var mapOpinion = OpinionsListDynamic.fromJson(element).opinionsListDynamic;
      Opinion opinion = Opinion.fromJson(mapOpinion);
      opinions.add(opinion);
    });
    return new OpinionsList(
        opinionsList: opinions
    );
  }
}

class OpinionsList2 {
  final List<Opinion> listOpinions;

  OpinionsList2({
    required this.listOpinions,
  });

  factory OpinionsList2.fromJson(List <dynamic> parsedJson) {
    List<Opinion> opinions = [];
    parsedJson.forEach((element) {
      Opinion opinion = Opinion.fromJson(element);
      opinions.add(opinion);
    });

    return new OpinionsList2(listOpinions: opinions);
  }
}