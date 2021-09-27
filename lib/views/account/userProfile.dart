import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/authentication/logout.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/service/user/userById.dart';
import 'package:weezli/views/account/email_verification.dart';
import 'package:weezli/views/account/personal.dart';
import 'package:weezli/views/account/phone_verification.dart';
import 'package:weezli/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<User?> getUser(int userId) async {
    User? user = await userById(userId);
    print(user);
    return user;
  }

  Future<int?> getActualUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user != null) {
      print(user.id);
      return user.id;
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final int userId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        appBar: AppBar(actions: [
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
        ]),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              FutureBuilder(
                  future: Future.wait([getUser(userId), getActualUser()]),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      User user = snapshot.data![0] as User;
                      int? actualUserId = snapshot.data![1];
                      return Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage('https://picsum.photos/200'),
                                radius: _mediaQuery.width / 7,
                              )
                            ]),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.firstname!,
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        if ((user.moyenneAvis != null) &
                            (user.moyenneAvis! != 0))
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
                                    "Avis : ",
                                    style: TextStyle(
                                      color: WeezlyColors.primary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: user.moyenneAvis!.toDouble(),
                                    direction: Axis.horizontal,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemSize: _mediaQuery.width < 321 ? 15 : 20,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.0),
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
                        SizedBox(height: 10),
                        Row(children: [
                          Text(
                            "Informations personnelles",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ]),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (actualUserId != null &&
                                        user.id == actualUserId)
                                      Row(children: [
                                        Text(
                                          "Nom",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            width: _mediaQuery.width * 0.3),
                                        Text(user.lastname!)
                                      ]),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      Text(
                                        "Prénom",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                          width: _mediaQuery.width * 0.245),
                                      Text(user.firstname!)
                                    ]),
                                    SizedBox(height: 10),
                                    if (actualUserId != null &&
                                        user.id == actualUserId)
                                      Row(children: [
                                        Text(
                                          "Date de naissance : ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            width: _mediaQuery.width * 0.027),
                                        Text(
                                          formatDate(user.dateOfBirthday!),
                                          textAlign: TextAlign.right,
                                        ),
                                      ]),
                                    SizedBox(height: 10),
                                    if (actualUserId != null &&
                                        user.id == actualUserId &&
                                        user.email != null)
                                      Row(children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            width: _mediaQuery.width * 0.3),
                                        Text(
                                          user.email!,
                                          textAlign: TextAlign.left,
                                        ),
                                      ]),
                                    SizedBox(height: 10),
                                    if (actualUserId != null &&
                                        user.id == actualUserId &&
                                        user.phone != null)
                                      Row(children: [
                                        Text(
                                          "Numéro de téléphone",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          user.phone!,
                                          textAlign: TextAlign.left,
                                        ),
                                      ]),
                                  ]),
                            ]),
                        SizedBox(height: 30),
                        Row(children: [
                          Text(
                            "Carte d'identité vérifiée",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          user.check!.statusIdentity == 0
                              ? Icon(
                                  WeezlyIcon.attention,
                                  color: Colors.red,
                                )
                              : Icon(
                                  WeezlyIcon.check_circle,
                                  color: WeezlyColors.green,
                                ),
                        ]),
                        SizedBox(height: 20),
                        Row(children: [
                          Text(
                            "Numéro de téléphone vérifié",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          user.check!.statusPhone == 0
                              ? Icon(
                                  WeezlyIcon.attention,
                                  color: Colors.red,
                                )
                              : Icon(
                                  WeezlyIcon.check_circle,
                                  color: WeezlyColors.green,
                                ),
                        ]),
                        SizedBox(height: 20),
                        Row(children: [
                          Text(
                            "Email vérifié",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          user.check!.statusEmail == 0
                              ? Icon(
                                  WeezlyIcon.attention,
                                  color: Colors.red,
                                )
                              : Icon(
                                  WeezlyIcon.check_circle,
                                  color: WeezlyColors.green,
                                ),
                        ]),
                        SizedBox(height: 40),
                        if (actualUserId != null && user.id == actualUserId)
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                width: 1,
                                color: WeezlyColors.primary,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/personal',
                                  arguments: user);
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                              child: Text(
                                "Modifier le profil",
                                style: TextStyle(
                                  color: WeezlyColors.primary,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          )
                      ]);
                    } else
                      return _buildLoadingScreen();
                  }),
            ],
          ),
        ))));
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
}
