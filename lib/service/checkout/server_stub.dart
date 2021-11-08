import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;


var id_choice;


recupIdPrice(id){
  id_choice = id;
}

class Server {
  Future<String> createCheckout() async {
    final auth = 'Basic ' + base64Encode(utf8.encode('$secretKey:'));

    final body = {

      "payment_method_types[]": 'card',
      'submit_type': 'auto',
      //'currency': 'eur',
      //"customer_email": "dev@test.com",
      //"customer" : "Test Test",
      'line_items': [
        {
          'price': id_choice,
          'quantity': 1,
        }
      ],

      'mode': 'payment',
      'success_url': 'http://localhost:8080/#/success',
      'cancel_url': 'http://localhost:8080/#/cancel',
    };
    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );

      print(result);
     return result.data['id'];
    } on DioError catch (e, s) {
      print(e.response);
      throw e;
    }
  }
}
