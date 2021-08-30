import 'dart:convert';

import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Avis extends StatefulWidget {
  const Avis({Key? key}) : super(key: key);

  @override
  _AvisState createState() => _AvisState();
}

class _AvisState extends State<Avis> {
  final List avis = [
    {
      "firstname": "Sandra",
      "lastname": "",
      "departure": "France",
      "arrival": "Madagascar",
      "text": "Commande satisfaisante arrivée à temps, livreur sérieux, ",
      "rating": 4,
    },
    {
      "firstname": "Carlos",
      "lastname": "Slim",
      "departure": "France",
      "arrival": "Italie",
      "text": "livreur avenant, très gentil et aimable",
      "rating": 4,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    Container _avisCard(String avisItem) {
      Map<String, dynamic> map = jsonDecode(avisItem);
      return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                  radius: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map["firstname"] + " " + map["lastname"],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            map["departure"],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.arrow_right_alt),
                          Text(
                            map["arrival"],
                          ),
                        ],
                      ),
                      Text(
                        map["text"],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: WeezlyColors.yellow,
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              WeezlyIcon.star,
                              size: 10,
                            ),
                            Text(
                              map["rating"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2,
              color: WeezlyColors.grey2,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Avis"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "John Doe",
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              width: _mediaQuery.width * 0.50,
              decoration: BoxDecoration(
                border: Border.all(color: WeezlyColors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(22.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Avis: ",
                    style: TextStyle(
                      color: WeezlyColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 4,
                    direction: Axis.horizontal,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: _mediaQuery.width < 321 ? 15 : 20,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: WeezlyColors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
            Text(avis.length.toString() + " avis"),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            for (dynamic item in avis) _avisCard(jsonEncode(item))
          ],
        ),
      ),
    );
  }
}
