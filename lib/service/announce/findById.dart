import 'dart:convert';
import 'package:weezli/model/Announce.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Announce> findById(int id) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/announce/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  var parsed = jsonDecode(response.body);
  var mapAnnounce = AnnouncesListDynamic.fromJson(parsed).announcesListDynamic;
  Announce announce = Announce.fromJson(mapAnnounce);
  return announce;

}