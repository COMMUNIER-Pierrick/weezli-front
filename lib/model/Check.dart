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
