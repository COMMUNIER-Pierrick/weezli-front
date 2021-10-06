import 'package:http/http.dart';
import 'package:http/http.dart' as http;

Future<Response> deleteAnnounce(int? id) async {

  final Response response = await http.delete(
    Uri.parse("http://10.0.2.2:5000/announce/remove-announce/" + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    });
  return response;
  }
