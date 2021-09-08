
import 'dart:convert';
import 'dart:ffi';

Opinion opinionFromJson(String str) => Opinion.fromJson(json.decode(str));

String opinionToJson(Opinion data) => json.encode(data.toJson());

class Opinion {
  Opinion({
    required this.id,
    required this.number,
    required this.comment,
  });

  int id;
  Double number;
  String comment;

  factory Opinion.fromJson(Map<String, dynamic> json) => Opinion(
        id: json["id"],
        number: json["number"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "comment": comment,
      };
}
