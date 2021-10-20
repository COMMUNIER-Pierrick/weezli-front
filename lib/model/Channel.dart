
import 'package:weezli/model/user.dart';


class Channel {
  Channel ({
    required this.id,
    required this.title,
    required this.users,

  });

  int id;
  String title;
  List <User> users;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
      id: json["id"],
      title: json["title"],
      users: json["usersIds"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "usersIds": users,

  };
}