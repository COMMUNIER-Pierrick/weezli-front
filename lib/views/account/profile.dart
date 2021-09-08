import 'package:baloogo/commons/disconnect.dart';
import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:baloogo/views/announce/announces.dart';
import 'package:baloogo/views/colis/search_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final double _separator = 20;

    Container _customButton(String text, String route) {
      return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.all(20),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              WeezlyColors.grey5,
            ),
            elevation: MaterialStateProperty.all<double>(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: WeezlyColors.black,
                ),
              ),
              Icon(
                WeezlyIcon.arrow_right,
                color: WeezlyColors.grey4,
                size: 14,
              )
            ],
          ),
        ),
      );
    }

    final List _list1 = [
      ["Profil personnel", "/personal"],
      ["Mes commandes", SearchOrders.routeName],
      ["Mes annonces", Announces.routeName],
      ["Paramètres", "/personal"],
    ];
    final List _list2 = [
      ["Paiement et transactions", "/paiement"],
      ["Détails du forfait", "/formules"],
    ];
    final List _list3 = [
      ["Aide", "/paiement"],
      ["Données et confidentialité", "/personal"],
    ];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          disconnect,
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                  radius: _mediaQuery.width / 7,
                ),
                SizedBox(
                  height: _separator,
                ),
                const Text(
                  "John Doe",
                  style: TextStyle(
                    color: WeezlyColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/avis");
                  },
                  child: Container(
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
                ),
                for (List<String> item in _list1)
                  _customButton(item[0], item[1]),
                SizedBox(
                  height: _separator,
                ),
                for (List<String> item in _list2)
                  _customButton(item[0], item[1]),
                SizedBox(
                  height: _separator,
                ),
                for (List<String> item in _list3)
                  _customButton(item[0], item[1]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
