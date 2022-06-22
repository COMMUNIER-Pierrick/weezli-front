import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/Proposition.dart';
import 'package:weezli/model/StatusProposition.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/proposition/updateProposition.dart';
import 'package:weezli/service/statusProposition/findStatusPropositionById.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/account/profile.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:weezli/views/propositions/search_propositions.dart';

class PropositionsDetails extends StatefulWidget {
  const PropositionsDetails({Key? key}) : super(key: key);
  static const String routeName = "/proposition-details";

  @override
  _PropositionsDetailsState createState() => _PropositionsDetailsState();
}

class _PropositionsDetailsState extends State<PropositionsDetails> {

  @override
  Widget build(BuildContext context) {

    final Size _mediaQuery = MediaQuery
        .of(context)
        .size;

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Proposition proposition = arg['proposition'];
    int idUser = arg['idUser'];

    final TextEditingController _counterOfferPriceCtrl = TextEditingController(
        text: proposition.proposition.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Détails"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, SearchPropositions.routeName, arguments: idUser)),
      ),
      body: Container(
        width: _mediaQuery.width,
        height: _mediaQuery.width * 1.3,
        padding: EdgeInsets.only(
          bottom: 15.0,
          top: 50.0,
        ),
        child:
        _viewProposition(proposition, idUser, _counterOfferPriceCtrl),
      )
    );
  }

  _viewProposition(Proposition proposition, int idUser, TextEditingController _counterOfferPriceCtrl) {
      return Container(
      child:
        Column(
          children: [
            if (((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id == idUser)) ||
                ((proposition.statusProposition.name == "Proposition") && (proposition.userProposition.id != idUser)))
            Container(
              child: Column(
                children:[
                  _title(proposition, idUser),
                    ElevatedButton(
                        onPressed: () =>
                            _viewDetailProposition(proposition, idUser,
                                _counterOfferPriceCtrl),
                        child: Text(
                          "Voir l'offre".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding:
                          EdgeInsets.symmetric(horizontal: 50),
                          primary: Theme
                              .of(context)
                              .buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(25)),
                        ))
                  ]),
            ),
            if (((proposition.statusProposition.name == "Proposition") && (proposition.userProposition.id == idUser)) ||
                ((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id != idUser)))
              Column(
                children: [
                  _title(proposition, idUser),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child:
                            Text("Montant que vous avez proposé : " + proposition.proposition.toString() + "€",
                                textAlign: TextAlign.center)
                        )
                      ]
                  ),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child:
                            Text("Dans l'attente d'une réponse de sa part",
                                textAlign: TextAlign.center)
                        )
                      ]
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _status(proposition.statusProposition.name)
                    ],
                  ),
                ]),
            if(proposition.statusProposition.name == "Validé")
              Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Prix accepté",
                          style: TextStyle(fontSize: 17,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,)
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child:
                              Text("Montant sur lequel vous vous êtes mis d'accord : " + proposition.proposition.toString() + "€",
                                  textAlign: TextAlign.center)
                          )
                        ]
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _status(proposition.statusProposition.name)
                      ],
                    ),
                  ]),
            if(proposition.statusProposition.name == "Refusé")
              Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Prix refusé",
                          style: TextStyle(fontSize: 17,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,)
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child:
                              Text("Aucun accord trouvé entre vous",
                                  textAlign: TextAlign.center)
                          )
                        ]
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _status(proposition.statusProposition.name)
                      ],
                    )
                  ]
              )
          ]
        )
      );
  }

  _title(Proposition proposition, int idUser){

    String title = "";
    String pseudoTitle = "";

    if ((proposition.statusProposition.name == "Proposition") && (proposition.userProposition.id == idUser)){
      title = "Proposition envoyé à :";
      pseudoTitle = proposition.announce.userAnnounce.username!;
    }else if ((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id != idUser)){
      title = "Contre-proposition envoyé à :";
      pseudoTitle = proposition.userProposition.username!;
    }else if ((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id == idUser)) {
      title = "Contre-proposition reçue de la part de :";
      pseudoTitle = proposition.announce.userAnnounce.username!;
    }else{
      title = "Proposition reçue de la part de :";
      pseudoTitle = proposition.userProposition.username!;
    }

    return
      Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pseudoTitle,
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10),
          ]);
  }

  _status(String statut){
    if(statut == "Proposition"){
      return Row(
        children: [
          Text("Proposition"),
          SizedBox(width: 10),
          Icon(
            Icons.circle,
            color: WeezlyColors.yellow,
          ),
          ]
      );
    }else if (statut == "Contre-proposition"){
      return Row(
          children: [
            Text("Contre-proposition"),
            SizedBox(width: 10),
            Icon(
              Icons.circle,
              color: WeezlyColors.orange,
            ),
            ]
      );
    }else if (statut == "Validé"){
      return
        Row(
            children: [
              Text("Validé"),
              SizedBox(width: 10),
              Icon(
                Icons.circle,
                color: WeezlyColors.green,
              ),
            ]
        );
    }else {
      return Row(
          children: [
            Text("Refusé"),
            SizedBox(width: 10),
            Icon(
              Icons.circle,
              color: WeezlyColors.red,
            ),
            ]
      );
    }
  }

  _viewDetailProposition(Proposition proposition, int idUser,
      TextEditingController _counterOfferPriceCtrl) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(
        prefs); //Vérifie si on a quelque chose en sharedpreferences (et donc si l'user est connecté). Le redirige vers le login sinon.
    if (user == null) {
      Navigator.pushNamed(context, "/login");
    }

    String title = "";
    String pseudoTitle = "";

    if ((proposition.statusProposition.name == "Contre-proposition") &&
        (proposition.userProposition.id == idUser)){
      title = "Contre-proposition reçue par :";
      pseudoTitle = proposition.announce.userAnnounce.username!;
    }
    if ((proposition.statusProposition.name == "Proposition") &&
        (proposition.userProposition.id != idUser)) {
      title = "Proposition reçue par :";
      pseudoTitle = proposition.userProposition.username!;
    }

    String text = "*Vous avez la possibiliter de faire une seule contre-proposition en modifiant le prix avant de valider";

    showDialog(
        context: context, builder: (BuildContext context) {
          return _buildPopupProposition(
            context,
            proposition,
            idUser,
            _counterOfferPriceCtrl,
            title,
            pseudoTitle,
            text,
        );
      });
  }

  Widget _buildPopupProposition(BuildContext context, Proposition proposition, int idUser,
      TextEditingController _counterOfferPriceCtrl, String title, String pseudoTitle, String text){

    return new Dialog(
      child:
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.all(10),
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                      style: TextStyle(fontSize: 17,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(pseudoTitle,
                      style: TextStyle(fontSize: 17,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                if (((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id != idUser)) ||
                    ((proposition.statusProposition.name == "Proposition") && (proposition.announce.userAnnounce.id == idUser)))
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                  SizedBox(height: 10),
                if (((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id == idUser)) ||
                    ((proposition.statusProposition.name == "Proposition") && (proposition.announce.userAnnounce.id != idUser)))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(proposition.proposition.toString() + " €",
                        style: TextStyle(fontSize: 17,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                          _offerOrCounterOfferRefuse(proposition, context);
                        },
                        child: const Text("REFUSER"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
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
                if (((proposition.statusProposition.name == "Contre-proposition") && (proposition.userProposition.id != idUser)) ||
                    ((proposition.statusProposition.name == "Proposition") && (proposition.announce.userAnnounce.id == idUser)))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LimitedBox(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                        child: Text(text,
                          textAlign: TextAlign.center,
                        ))
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
            )
        )
    );
  }

  _offerOrCounterOfferRefuse(Proposition proposition, BuildContext context) async {
    // Récupération du statusProposition refuser
    StatusProposition statusPropositionRefuser = await findStatusPropositionById(
        4);

    // Vérification si l'utilisateur est bien connecter
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user == null)
      Navigator.pushNamed(context, "/login");
    else {
      // Modification de l'objet proposition à envoyer au back
      Proposition newProposition = Proposition(
        announce: proposition.announce,
        userProposition: proposition.userProposition,
        proposition: proposition.proposition,
        statusProposition: statusPropositionRefuser,
      );
      var response = await updateProposition(newProposition);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Modification enregistrée')),
        );
        Navigator.pushNamed(context, Profile.routeName);
      }
    }
  }

  _createOrderOrCounterOffer(Proposition proposition, BuildContext context, TextEditingController priceController) async{

    // Vérification si l'utilisateur est bien connecter
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user == null)
      Navigator.pushNamed(context, "/login");
    else if (proposition.proposition == int.parse(priceController.text)) {
      // Récupération du statusProposition valider
      StatusProposition statusPropositionValider = await findStatusPropositionById(3);
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
        },);
      }//newOrder
      }else {
        // Récupération du statusProposition contre-proposition
        StatusProposition statusPropositionContreproposition = await findStatusPropositionById(2);
        // Modification de l'objet proposition à envoyer au back
        Proposition newProposition = Proposition(
          announce: proposition.announce,
          userProposition: proposition.userProposition,
          proposition: int.parse(priceController.text),
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