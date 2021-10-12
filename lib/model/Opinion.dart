
import 'dart:convert';

import 'Order.dart';

Opinion opinionFromJson(String str) => Opinion.fromJson(json.decode(str));

String opinionToJson(Opinion data) => json.encode(data.toJson());

class Opinion {
  Opinion({
    required this.id,
    required this.number,
    this.comment,
    required this.order,
  });

  int id;
  double number;
  String? comment;
  Order order;

  factory Opinion.fromJson(Map<String, dynamic> json) => Opinion(
        id: json["id"],
        number: json["number"],
        comment: json["comment"],
        order : json ["id_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "comment": comment,
        "id_order" : order,
      };
}
