
import 'dart:convert';

StatusProposition statusPropositionFromJSon(String str) => StatusProposition.fromJson(json.decode(str));

String statusPropositionToJson(StatusProposition data) => json.encode(data.toJson());

class StatusProposition {
  StatusProposition ({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory StatusProposition.fromJson(Map<String, dynamic> json) => StatusProposition(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
class StatusPropositionListMap{
  StatusPropositionListMap({
  required this.list,
});

List <dynamic> list;

factory StatusPropositionListMap.fromJson(Map<String, dynamic> json){
  return StatusPropositionListMap(
  list: json["StatusPropositions"]
  );}
}

class StatusPropositionList{
  StatusPropositionList({
    required this.statusPropositionList,
  });

  List<StatusProposition> statusPropositionList;

  factory StatusPropositionList.fromJson(List<dynamic> parsedJson){
    List<StatusProposition> statusPropositions = [];
    parsedJson.forEach((element) {
      var mapStatusProposition = StatusPropositionListDynamic.fromJson(element).statusPropositionListDynamic;
      StatusProposition statusProposition = StatusProposition.fromJson(mapStatusProposition);
      statusPropositions.add(statusProposition);
    });

    return new StatusPropositionList(
        statusPropositionList: statusPropositions
    );
  }
}

class StatusPropositionListDynamic{
  StatusPropositionListDynamic({
    required this.statusPropositionListDynamic
  });

  Map <String, dynamic> statusPropositionListDynamic;

  factory StatusPropositionListDynamic.fromJson(Map<String, dynamic> json){
    return StatusPropositionListDynamic(
        statusPropositionListDynamic: json ["Status_proposition"]
    );
  }
}
