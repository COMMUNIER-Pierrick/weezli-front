import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/authentication/logout.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/account/userProfile.dart';
import 'package:weezli/views/announce/announces.dart';
import 'package:weezli/views/authentication/login.dart';
import 'package:weezli/views/deliveries/search_deliveries.dart';
import 'package:weezli/views/orders/search_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = await getUserInfo(prefs);
    if (user == null)
      Navigator.pushNamed(context, '/login');
    else
      return user;
  }

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final double _separator = 20;

    Container _customButton(String text, String route, int? userId) {
      return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, route, arguments: userId);
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
      ["Profil personnel", UserProfile.routeName],
      ["Mes commandes", SearchOrders.routeName],
      ["Mes livraisons", SearchDeliveries.routeName],
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
        actions: [
          Padding(
              padding: EdgeInsets.all(20),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Déconnexion",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          logout();
                          Navigator.pushNamed(context, '/');
                        })))
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, "/")),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200'),
                radius: _mediaQuery.width / 7,
              ),
              SizedBox(
                height: _separator,
              ),
              FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      User user = snapshot.data as User;
                      return Container(
                          child: Column(children: [
                        Text(
                          user.firstname! + " " + user.lastname!,
                          style: TextStyle(
                            color: WeezlyColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        for (List<String> item in _list1)
                          _customButton(item[0], item[1], user.id),
                        SizedBox(
                          height: _separator,
                        ),
                        for (List<String> item in _list2)
                          _customButton(item[0], item[1], user.id),
                        SizedBox(
                          height: _separator,
                        ),
                        for (List<String> item in _list3)
                          _customButton(item[0], item[1], user.id),
                      ]));
                    }
                    return _buildLoadingScreen();
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _buildLoadingScreen() {
  return Center(
    child: Container(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(),
    ),
  );
}
