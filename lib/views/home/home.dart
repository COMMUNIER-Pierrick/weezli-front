import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/views/announce/announce_detail.dart';
import 'package:weezli/views/announce/create_sender_announce.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/views/search/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _separator = 20;

  searchPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userStr = prefs.getString('user');
    print (userStr);
    return userStr;
  }


  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final userStr = searchPrefs();

    final Container header = Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: _mediaQuery.height * 0.33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        image: DecorationImage(
          image: AssetImage("assets/images/header-home.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: WeezlyColors.white,
              border: Border.all(color: WeezlyColors.white),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Text(
              "logo",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: _separator,
          ),
          /*
          Text(
            "TRANSPORT\nDE COLIS ENTRE\nPARTICULIERS",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(20, 37, 83, 1),
            ),
          ),
          SizedBox(
            height: _separator,
          ),
          Text(
            "Envoie de colis\npas cher, rapide\net écolo",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(20, 37, 83, 1),
            ),
          ),
          */
        ],
      ),
    );
    final double _fontSize = _mediaQuery.width <= 280 ? 12 : 14;
    final Row buttonsRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: _mediaQuery.width * 0.4,
          height: 45,
          child: RawMaterialButton(
            fillColor: WeezlyColors.primary,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.5),
            ),
            onPressed: () => Navigator.pushNamed(context, Search.routeName,
                arguments: 'sending'),
            child: const Text("J'EXPÉDIE"),
          ),
        ),
        SizedBox(
          width: _mediaQuery.width * 0.4,
          height: 45,
          child: RawMaterialButton(
            fillColor: WeezlyColors.yellowgreen,
            textStyle: TextStyle(
              color: WeezlyColors.primary,
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.5)),
            onPressed: () => Navigator.pushNamed(context, Search.routeName,
                arguments: 'transfer'),
            child: const Text("JE TRANSPORTE"),
          ),
        ),
      ],
    );
    Widget largeButton1(
      String img,
      String text,
    ) {
      return InkWell(
          onTap: () => Navigator.pushNamed(context, '/formules'),
          child: Container(
            width: _mediaQuery.width * 0.9,
            height: 104,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Icon(
                  WeezlyIcon.arrow_right_circle,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ));
    }

    Widget largeButton2(
      String img,
      String text,
    ) {
      return InkWell(
        //onTap: () => Navigator.pushNamed(context, '/formules'),
        onTap: () => Navigator.pushNamed(context, AnnounceDetail.routeName),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: _mediaQuery.width * 0.9,
          height: 104,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: WeezlyColors.green,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              alignment: Alignment.centerRight,
              image: AssetImage(
                img,
              ),
              fit: BoxFit.contain,
            ),
          ),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(
                WeezlyIcon.arrow_right_circle,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      );
    }

    final Row buttonsRow2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: _mediaQuery.width * 0.4,
          height: 45,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: WeezlyColors.blue2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.5),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              "INSCRIVEZ-VOUS",
              style: TextStyle(
                color: Color.fromRGBO(20, 37, 83, 1),
                fontSize: _fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          width: _mediaQuery.width * 0.4,
          height: 45,
          child: RawMaterialButton(
            fillColor: Color.fromRGBO(109, 167, 246, 1),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.5)),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              "CONNECTEZ-VOUS",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              header,
              //ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/formules'), child: Text("Formules")),
              Padding(
                padding: EdgeInsets.only(
                  top: 22,
                  bottom: 22,
                ),
                child: buttonsRow,
              ),
              largeButton1("assets/images/comment.png", "COMMENT\nÇA MARCHE"),
              largeButton2("assets/images/moyens2.png", "FORMULES"),
              if (userStr == "null")
                Text(
                  "INSCRIPTION GRATUITE",
                  style: TextStyle(
                    color: Color.fromRGBO(20, 37, 83, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              SizedBox(
                height: 22,
              ),
              if (userStr == null)
              Text(
                "Inscrivez-vous pour consulter ou déposer\ndes annonces et pour "
                "entrer en contact\navec d’autres annonceurs !\n\n"
                "Si vous êtes déjà membre, vous devez tout\n"
                "simplement vous connecter.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(20, 37, 83, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              if (userStr == null)
              Padding(
                padding: EdgeInsets.only(
                  top: 22,
                  bottom: 22,
                ),
                child: buttonsRow2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
