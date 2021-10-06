import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:http_parser/http_parser.dart';

Future<Response> createSenderAnnounce(Announce newAnnounce, List <File> imgList) async {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  var str;

  try {
    var addressDeparture = {};
    var resBodyAddressDeparture = {};
    resBodyAddressDeparture ["city"] = newAnnounce.package.addressDeparture.city;
    resBodyAddressDeparture["country"] = newAnnounce.package.addressDeparture.country;
    resBodyAddressDeparture["idInfo"] = 1;
    resBodyAddressDeparture["number"] = '';
    resBodyAddressDeparture["street"] = '';
    resBodyAddressDeparture["additionalAddress"] = '';
    resBodyAddressDeparture["zipCode"] = '';
    addressDeparture = resBodyAddressDeparture;

    var addressArrival = {};
    var resBodyAddressArrival = {};
    resBodyAddressArrival ["city"] = newAnnounce.package.addressArrival.city;
    resBodyAddressArrival["country"] = newAnnounce.package.addressArrival.country;
    resBodyAddressArrival["idInfo"] = 2;
    resBodyAddressArrival["number"] = '';
    resBodyAddressArrival["street"] = '';
    resBodyAddressArrival["additionalAddress"] = '';
    resBodyAddressArrival["zipCode"] = '';
    addressArrival = resBodyAddressArrival;

    var sizeslist = allSizesToJson(newAnnounce.package.size);

    var package = {};
    package["addressDeparture"] = addressDeparture;
    package["addressArrival"] = addressArrival;
    package["datetimeDeparture"] = newAnnounce.package.datetimeDeparture!.toIso8601String();
    package["datetimeArrival"] = '';
    package["kgAvailable"] = newAnnounce.package.kgAvailable.toDouble();
    package["description"] = newAnnounce.package.description;
    package["idTransport"] = 1;
    package["sizes"] = sizeslist;

    var userAnnounce = {};
    userAnnounce["id"] = newAnnounce.userAnnounce!.id;
    userAnnounce["firstname"] = newAnnounce.userAnnounce!.firstname;
    userAnnounce["lastname"] = newAnnounce.userAnnounce!.lastname;


    var resBody = {};
    resBody["packages"] = package;
    resBody["idType"] =  newAnnounce.type;
    resBody["price"] =  '';
    resBody["transact"] =  '';
    resBody["imgUrl"] =  '';
    resBody["dateCreated"] =  newAnnounce.dateCreated!.toIso8601String();
    resBody["userAnnounce"] = userAnnounce;

    str = encoder.convert(resBody);
  } catch(e) {
    print(e);
  }

  var request = http.MultipartRequest('POST', Uri.parse("http://10.0.2.2:5000/announce/new-announce"));
  Map<String, String> headers = {
    "Content-Type": "multipart/form-data",
    "Accept": "application/json",
  };

  String? filename;
  int i = 0;

  imgList.forEach((element) {
    switch (i) {
      case 0 :
        filename = "fileOne";
        break;
      case 1 :
        filename = "fileTwo";
        break;
      case 2 :
        filename = "fileThree";
        break;
      case 3 :
        filename = "fileFour";
        break;
      case 4 :
        filename = "fileFive";
        break;
    }


    request.files.add(http.MultipartFile(
      filename!,
      element.readAsBytes().asStream(),
      element.lengthSync(),
      filename: filename! + ".jpg",
      contentType: MediaType('image', 'jpeg'),
    ));

    i = i+1;
  });

  request.headers.addAll(headers);

  request.fields['Announce'] = str;
  print (request.fields);

  http.Response response = await http.Response.fromStream(await request.send());

  return response;

}