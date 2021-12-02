import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/model/Opinion.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/opinion/modifyOpinion.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/service/user/updateAverageOpinion.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ColisAvis extends StatefulWidget {
  const ColisAvis({Key? key}) : super(key: key);
  static const routeName = '/colis-avis';

  @override
  _ColisAvisState createState() => _ColisAvisState();
}

class _ColisAvisState extends State<ColisAvis> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Order order= arg['order'];
    int idUser= arg['idUser'];
    Opinion opinionUser = arg['opinionUser'];
    final Size _mediaQuery = MediaQuery.of(context).size;
    final double _separator = 20;
    dynamic note = opinionUser.number;
    final TextEditingController _commentController = TextEditingController(
        text: opinionUser.comment
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Mon avis"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Donner un avis",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: _separator,
              ),
              RatingBar(
                initialRating: opinionUser.number.toDouble(),
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                allowHalfRating: true,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: WeezlyColors.primary,
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: WeezlyColors.primary,
                  ),
                  empty: Icon(
                    Icons.star_border,
                    color: WeezlyColors.primary,
                  ),
                ),
                onRatingUpdate: (rating) {
                  note = rating;
                },
              ),
              SizedBox(
                height: _separator,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: WeezlyColors.grey1,
                child: TextFormField(
                  maxLines: 5,
                  controller: _commentController,
                  onTap: () => _commentController.clear(),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: WeezlyColors.blue3,
                      ),
                    ),
                    labelText: "Partagez votre expérience",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _separator,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _mediaQuery.width * 0.4,
                    height: 45,
                    child: OutlinedButton(
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
                        Navigator.pushNamed(context, OrderDetail.routeName, arguments: {'order': order, 'idUser': idUser});
                      },
                      child: Text(
                        "ANNULER",
                        style: TextStyle(
                          color: WeezlyColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _mediaQuery.width * 0.4,
                    height: 45,
                    child: RawMaterialButton(
                      fillColor: WeezlyColors.primary,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.5)),
                      onPressed: () => _modifyOpinion(opinionUser, note, _commentController, idUser, order),
                        //Navigator.pushNamed(context, OrderDetail.routeName, arguments: {'order': order, 'idUser': idUser});

                      child: const Text(
                        "NOTER",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  _modifyOpinion(Opinion opinionUser, dynamic note,
      TextEditingController _commentController, int idUser, Order order) async {
    // Vérification si l'utilisateur est bien connecter
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user == null) {
      Navigator.pushNamed(context, "/login");
    } else {
      // Création de l'objet opinion à envoyer au back pour être mis a jour
      Opinion opinion = Opinion(
          id: opinionUser.id,
          number: note,
          comment: _commentController.text,
          idUser: opinionUser.idUser,
          status: "Active",
          idUserOpinion: opinionUser.idUserOpinion,
          idTypes: opinionUser.idTypes
      );
      var responseOpinion = await modifyOpinion(opinion);
      if (responseOpinion.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avis modifiée !')),
        );

        /*Navigator.pushNamed(context, Profile.routeName, arguments: {
          'idUser': idUser
        },
        );*/ //newOrder
      }
    }
  }
}
