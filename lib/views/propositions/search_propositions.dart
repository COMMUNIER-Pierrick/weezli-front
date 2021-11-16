import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/Proposition.dart';
import 'package:weezli/model/StatusProposition.dart';
import 'package:weezli/model/user.dart';
import 'package:flutter/material.dart';
import 'package:weezli/service/proposition/findAllByUser.dart';
import 'package:weezli/service/proposition/updateProposition.dart';
import 'package:weezli/service/statusProposition/findStatusPropositionById.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:weezli/widgets/build_loading_screen.dart';

class SearchPropositions extends StatefulWidget {
  const SearchPropositions({Key? key}) : super(key: key);
  static const String routeName = "/all-proposition";

  @override
  _SearchPropositionsState createState() => _SearchPropositionsState();
}

class _SearchPropositionsState extends State<SearchPropositions> {
  final TextEditingController _searchController = TextEditingController();

  List<Proposition> listPropositions = [];

  Future<List<Proposition>> getPropositionsList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    listPropositions = await findAllByUser(user!.id);
    return listPropositions;
  }

  Future<User?> getActualUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    return user;
  }

  @override
  Widget build(BuildContext context) {

    final Size _mediaQuery = MediaQuery
        .of(context)
        .size;
    final Container _searchBar = Container(
      padding: EdgeInsets.only(
        bottom: 15.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              width: _mediaQuery.width * 0.8,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Recherche",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: WeezlyColors.blue3),
                  ),
                  suffixIcon: Icon(
                    WeezlyIcon.search,
                    color: WeezlyColors.white,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            WeezlyIcon.calendar,
            color: WeezlyColors.white,
          ),
        ],
      ),
    );

    GestureDetector _cardProposition(Proposition proposition, int idUser) {
      final TextEditingController _counterOfferPriceCtrl = TextEditingController(
          text: proposition.proposition.toString());
      return GestureDetector(
          onTap: () {
            /*Navigator.pushNamed(context, PropositionDetail.routeName,
                arguments: {
                  'proposition': proposition,
                  'idUser': idUser
                },);*/
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            width: _mediaQuery.width,
            decoration: BoxDecoration(
              color: WeezlyColors.grey1,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title(proposition, idUser),
                SizedBox(height: 10),
                if(proposition.userProposition.id != idUser)
                Column(
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          controller: _counterOfferPriceCtrl,
                          onTap: () => _counterOfferPriceCtrl.clear(),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.euro),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        height: 35,
                        child: RawMaterialButton(
                          fillColor: WeezlyColors.white,
                          textStyle: TextStyle(
                            color: WeezlyColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.5),
                              side: BorderSide(color: WeezlyColors.primary)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("ANNULER"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        height: 35,
                        child: RawMaterialButton(
                          fillColor: WeezlyColors.primary,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.5),
                          ),
                          onPressed: () =>
                              _createOrderOrCounterOffer(
                                  proposition, context, _counterOfferPriceCtrl),
                          child: const Text("VALIDER"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LimitedBox(
                          maxWidth: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
                          child: Text(
                            "*Vous avez la possibiliter de faire une seule contre-proposition en modifiant le prix avant de valider",
                            textAlign: TextAlign.center,
                          ))
                    ],
                  )],
                ),
                if(proposition.userProposition.id == idUser)
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Montant que vous avez proposer : " + proposition.proposition.toString() + "€")
                          ]
                    ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dans l'attente d'une réponse de sa part")
                        ]
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _status(proposition.statusProposition.name)
                  ],
                ),
              ],
            ),
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Propositions"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: _searchBar,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: Future.wait([getPropositionsList(), getActualUser()]),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      List<Proposition> listPropositions = snapshot
                          .data![0] as List<Proposition>;
                      User user = snapshot.data![1] as User;
                      return Container(
                          child: Column(children: [
                            for (Proposition proposition in listPropositions) _cardProposition(
                                proposition, user.id!),
                          ]));
                    } else
                      return buildLoadingScreen();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _title(Proposition proposition, int idUser) {
    if ((proposition.statusProposition.name == "Contre-proposition") &&
        (proposition.userProposition.id == idUser)) {
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Contre-proposition reçu par :",
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(proposition.announce.userAnnounce.username!,
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
    } else if ((proposition.statusProposition.name == "Contre-proposition") &&
        (proposition.userProposition.id != idUser)) {
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Contre-proposition envoyer a :",
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(proposition.userProposition.username!,
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
    } else if ((proposition.statusProposition.name == "Proposition") &&
        (proposition.userProposition.id != idUser)) {
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Proposition reçu par :",
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(proposition.userProposition.username!,
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
    } else if ((proposition.statusProposition.name == "Proposition") &&
        (proposition.userProposition.id == idUser)) {
      return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Proposition envoyer a :",
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(proposition.announce.userAnnounce.username!,
                  style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
    }else{
      return Column();// A supprimer une fois que l'on utilisera une list de proposition trier
    }
  }

  _status(String statut){
    if(statut == "Proposition"){
      return Row(
        children: [
        Row(children: [
          Icon(
            Icons.circle,
            color: WeezlyColors.yellow,
          ),
          SizedBox(width: 10),
          Text("Proposition"),
          ]
        )]
      );
    }else if (statut == "Contre-proposition"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.orange,
              ),
              SizedBox(width: 10),
              Text("Contre-proposition"),
            ]
            )]
      );
    }else if (statut == "Validé"){
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.green,
              ),
              SizedBox(width: 10),
              Text("Validé"),
            ]
            )]
      );
    }else {
      return Row(
          children: [
            Row(children: [
              Icon(
                Icons.circle,
                color: WeezlyColors.red,
              ),
              SizedBox(width: 10),
              Text("Refusé"),
            ]
            )]
      );
    }
  }

  _createOrderOrCounterOffer(Proposition proposition, BuildContext context, TextEditingController priceController) async{
    // Récupération du statusProposition valider
    StatusProposition statusPropositionValider = await findStatusPropositionById(3);

    // Récupération du statusProposition contre-proposition
    StatusProposition statusPropositionContreproposition = await findStatusPropositionById(2);

    // Vérification si l'utilisateur est bien connecter
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user == null)
      Navigator.pushNamed(context, "/login");
    else if (proposition.proposition == double.parse(priceController.text)) {
      // Modification de l'objet proposition à envoyer au back
      Proposition newProposition = Proposition(
        announce: proposition.announce,
        userProposition: proposition.userProposition,
        proposition: proposition.proposition,
        statusProposition: statusPropositionValider,
      );
      var response = await updateProposition(newProposition);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proposition créée !')),
        );
        var mapOrder = OrdersListDynamic
            .fromJson(jsonDecode(response.body))
            .ordersListDynamic;
        Order newOrder = Order.fromJson(mapOrder);

        Navigator.pushNamed(context, OrderDetail.routeName, arguments: {
          'order': newOrder,
          'idUser': proposition.announce.userAnnounce.id
        },); //newOrder
      }else if (proposition.proposition != double.parse(priceController.text)) {
        // Modification de l'objet proposition à envoyer au back
        Proposition newProposition = Proposition(
          announce: proposition.announce,
          userProposition: proposition.userProposition,
          proposition: double.parse(priceController.text),
          statusProposition: statusPropositionContreproposition,
        );
        // On récupère le json renvoyé et on le convertit en objet order pour l'envoyer à la route.
        var response = await updateProposition(newProposition);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contre-proposition envoyée !')),
          );
          Navigator.pushNamed(context, '/');
        }
      }
    }
  }
}

