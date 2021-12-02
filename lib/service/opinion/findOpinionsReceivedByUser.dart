import 'dart:convert';
import 'package:weezli/model/Opinion.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Opinion>> findOpinionsReceivedByUser(int idUser) async {

  final Response response = await http.get(
    Uri.parse("http://10.0.2.2:5000/opinion/get-all-opinion-received-user/" + idUser.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );

  List<Opinion> opinionsList = [];
  final parsed = jsonDecode(response.body);
  var opinionsListMap = OpinionsListMap.fromJson(parsed).list;
  opinionsList = OpinionsList.fromJson(opinionsListMap).opinionsList;
  return opinionsList;

}