

class Status {
  Status ({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
class StatusListMap{
  StatusListMap({
    required this.list,
  });

  List <dynamic> list;

  factory StatusListMap.fromJson(Map<String, dynamic> json){
    return StatusListMap(
        list: json["Status"]
    );}
}

class StatusList{
  StatusList({
    required this.statusList,
  });

  List<Status> statusList;

  factory StatusList.fromJson(List<dynamic> parsedJson){
    List<Status> listStatus = [];
    parsedJson.forEach((element) {
      var mapStatus = StatusListDynamic.fromJson(element).statusListDynamic;
      Status status = Status.fromJson(mapStatus);
      listStatus.add(status);
    });

    return new StatusList(
        statusList: listStatus
    );
  }
}

class StatusListDynamic{
  StatusListDynamic({
    required this.statusListDynamic
  });

  Map <String, dynamic> statusListDynamic;

  factory StatusListDynamic.fromJson(Map<String, dynamic> json){
    return StatusListDynamic(
        statusListDynamic: json ["Status"]
    );
  }
}
