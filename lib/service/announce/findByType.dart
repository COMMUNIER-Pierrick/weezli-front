import 'dart:convert';
import 'dart:developer';
import 'package:weezli/model/Announce.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Announce>> findByType(int type) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/announce/announces-by-type/" + type.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Announce> announcesList = [];
  final parsed = jsonDecode(response.body);

  var announcesListMap = AnnouncesListMap.fromJson(parsed).list;
  announcesList = AnnouncesList.fromJson(announcesListMap).announcesList;
  return announcesList;


}

