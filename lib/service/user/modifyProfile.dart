import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weezli/model/user.dart';

Future<Response> modifyProfile(User account) async {
  String str = "";
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  try {

    var address = {};
    var resBodyAddress = {};
    resBodyAddress ["city"] = account.address![0].city;
    resBodyAddress["country"] = account.address![0].country;
    resBodyAddress["number"] = account.address![0].number;
    resBodyAddress["street"] = account.address![0].street;
    resBodyAddress["zipCode"] = account.address![0].zipCode;
    resBodyAddress["name"] = '';
    resBodyAddress["additionalAddress"] = '';
    resBodyAddress["idInfo"] = 3;
    address = resBodyAddress;

    var resBody = {};
    resBody["firstname"] = account.firstname;
    resBody["lastname"] =  account.lastname;
    resBody["phone"] =  account.phone;
    resBody["email"] =  account.email;
    resBody["url_profile_img"] = "";
    resBody["address"] = address;
    resBody ["check"] = {
      "id" : 13,
      "imgIdentity" : "picture789.png"
    };

    str = encoder.convert(resBody);
    print(str);
  } catch(e) {
    print(e);
  }

  String url = "http://10.0.2.2:5000/user/update-profile/" + account.id.toString();
  print (url);

  var request = http.MultipartRequest('PUT', Uri.parse(url));
  Map<String, String> headers = {
    "Content-Type": "multipart/form-data",
    "Accept": "application/json",
  };

  request.headers.addAll(headers);

  request.fields['User'] = str;

  http.Response response = await http.Response.fromStream(await request.send());

  print (response.statusCode);

  return response;

}