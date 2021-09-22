import 'dart:convert';

import 'dart:ffi';

Check checkFromJson(String str) => Check.fromJson(json.decode(str));
String checkToJson(Check data) => json.encode(data.toJson());

class Check {

  Check({
    required this.id,
    required this.statusPhone,
    required this.statusIdentity,
    this.imgIdCard,

  });

  int id;
  int statusPhone;
  int statusIdentity;
  String? imgIdCard;


  factory Check.fromJson(Map<String, dynamic> json) => Check(
    id: json["id"],
    statusPhone: json ["statusPhone"],
    statusIdentity: json ["statusIdentity"],
    imgIdCard: json ["imgIdCard"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "statusPhone": statusPhone,
    "statusIdentity": statusIdentity,
    "imgIdCard": imgIdCard,
  };
}
