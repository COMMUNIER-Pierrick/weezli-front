
import 'dart:convert';
import 'dart:ffi';

import 'package:weezli/model/user.dart';

import 'Channel.dart';
import 'Price.dart';


Message MessageFromJson(String str) => Message.fromJson(json.decode(str));

String MessageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message ({
    required this.id,
    required this.text,
    required this.author,
    required this.channel,
    required this.dateCreated,
    required this.propositionPrice,

  });

  int id;
  String text;
  User author;
  Channel channel;
  DateTime dateCreated;
  Price propositionPrice;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    text: json["text"],
    author: json["idAuthor"],
    channel: json["idChannel"],
    dateCreated: DateTime.parse (json ["dateCreated"]),
    propositionPrice: json ["id_proposition_price"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "idAuthor": author,
    "idChannel": channel,
    "dateCreated": dateCreated,
    "id_proposition_price" : propositionPrice,

  };
}