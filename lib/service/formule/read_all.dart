import 'dart:convert';
import 'dart:developer';
import 'package:weezli/model/Choice.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<List<Choice>> readAllFormules() async {
  final String url = "http://10.0.2.2:5000/choice/all-choices";

  final Response response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    },
  );
  List<Choice> choiceList = [];
  final parsed = jsonDecode(response.body);
  var choices = ChoiceListMap.fromJson(parsed).list;
  choices.remove(choices[0]);
  choiceList = ChoiceList.fromJson(choices).choiceList;
  return choiceList;
}
