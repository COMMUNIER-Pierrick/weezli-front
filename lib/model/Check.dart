import 'dart:convert';

Check checkFromJson(String str) => Check.fromJson(json.decode(str));
String checkToJson(Check data) => json.encode(data.toJson());

class Check {

  Check({
    required this.id,
    required this.statusPhone,
    required this.statusIdentity,
    required this.statusEmail,
    this.filename,
    this.status,
    this.code,

  });

  int id;
  int statusPhone;
  int statusIdentity;
  int statusEmail;
  String? filename;
  String? status;
  String? code;


  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
      id: json["id"],
      statusPhone: json ["statusPhone"],
      statusIdentity: json ["statusIdentity"],
      statusEmail: json ["statusMail"],
      filename: json ["filename"],
      status: json["status"],
      code: json["code"],
    );
  }

    Map<String, dynamic> toJson() => {
      "id": id,
      "statusPhone": statusPhone,
      "statusIdentity": statusIdentity,
      "statusEmail" : statusEmail,
      "filename": filename,
    };
  }
// Récupère une liste dynamique à partir de la map renvoyée par le json.

class ChecksListMap {
  ChecksListMap({
    required this.list,
  });

  List <dynamic> list;

  factory ChecksListMap.fromJson(Map<String, dynamic> json) {
    return ChecksListMap(
        list: json ["Checks"]);
  }
}

// Passe d'une liste dynamique à un objet map pour créer une check utilisateur.

class ChecksListDynamic {
  ChecksListDynamic({
    required this.checksListDynamic,
  });

  Map <String, dynamic> checksListDynamic;

  factory ChecksListDynamic.fromJson(Map<String, dynamic> json) {
    return ChecksListDynamic(
        checksListDynamic: json ["Check"]);
  }
}

class ChecksList {
  ChecksList({
    required this.checksList,
  });

  List<Check> checksList;

  //Récupère une liste dynamique pour créer check par check, puis recréer une liste de checks.

  factory ChecksList.fromJson(List<dynamic> parsedJson) {
    List<Check> checks = [];
    parsedJson.forEach((element) {
      var mapCheck = ChecksListDynamic
          .fromJson(element)
          .checksListDynamic;
      Check check = Check.fromJson(mapCheck);
      checks.add(check);
    });

    return new ChecksList(
        checksList: checks
    );
  }
}