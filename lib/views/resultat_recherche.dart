import 'package:baloogo/commons/weezly_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/card_item.dart';
import '../../views/announce/create_carrier_announce.dart';
import '../../views/announce/create_sender_announce.dart';

class ResultatRecherche extends StatefulWidget {
  @override
  ResultatRechercheState createState() => ResultatRechercheState();
}

class ResultatRechercheState extends State<ResultatRecherche> {
  bool sendBool = true;

  @override
  Widget build(BuildContext context) {
    final searchValues = ModalRoute.of(context)!.settings.arguments as Map?;
    print(searchValues);
    return Scaffold(
      appBar: AppBar(
        title: Text("Résultats recherche"),
        backgroundColor: searchValues!["type"] == "sending" ? WeezlyColors.blue2: WeezlyColors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () => searchValues["type"] == 'transfer'
                  ? Navigator.pushNamed(
                      context, CreateCarrierAnnounce.routeName)
                  : Navigator.pushNamed(
                      context, CreateSenderAnnounce.routeName),
              child: Text(
                "Déposer une annonce pour votre colis sur ce trajet.",
                textAlign: TextAlign.center,
              ),
              style: OutlinedButton.styleFrom(
                  primary: Colors.blue,
                  side: BorderSide(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fixedSize: Size.fromWidth(300),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50)),
            ),
            Divider(
              thickness: 2,
            ),
            CardItem(searchValues),
            CardItem(searchValues),
            CardItem(searchValues),
            Divider(
              color: Colors.blue,
              thickness: 2,
            ),
          ],
        ),
      ),
    ); //fin return
  }
}
