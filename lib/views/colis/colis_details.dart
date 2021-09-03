
import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:baloogo/model/colis.dart';
import 'package:baloogo/service/colis/read_one.dart';
import 'package:flutter/material.dart';

import 'colis_avis.dart';

class ColisDetail extends StatefulWidget{
  
  @override
  ColisDetailState createState () => ColisDetailState();

  static const routeName = '/colis-details';
}
class ColisDetailState extends State<ColisDetail>{

  
  late Future<Colis> colisFuture;
  late Colis thisColis;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colisFuture = readOneColis(2);
    colisFuture.then((value) {
      setState(() => thisColis = value);
    });
  }

 //----------------------  Début brut  ----------------------------------------
  Colis colis = Colis(
      id: 215545454,
      commandDate: '01-07-2021   15:21',
      departure: 'France',
      arrival: 'Madagascar',
      departureDate: DateTime.parse('1969-07-20 20:18:04Z'),
      dimension: 'Petit',
      poids: 0,
      montant: 20,
      deliverName: 'Melinda Rochel',
      validationCode: '25456',
      description: 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed non risus. Suspendisse lectus '
          'tortor, dignissim sit amet, adipiscing nec, '
          'ultricies sed, dolor. Cras '
          'elementum ultrices diam. Maecenas ligula massa, ',
      status: false);
   //----------------------  Fin brut  ----------------------------------------
  double _separator = 10;

  @override
  Widget build(BuildContext context) {
    
    final Size _mediaQuery = MediaQuery.of(context).size;

    Row mix(IconData icon, String key, String value) {
      return Row(
        children: <Widget>[
          Icon(
            icon,
            color: WeezlyColors.blue3,
          ),
          SizedBox(
            width: _separator + 10,
          ),
          Text(key),
          Text(
            value,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes colis"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("N° de commande : " + thisColis.id.toString()),
              Text("Du : " + thisColis.commandDate
                .replaceFirst("T", " à ")
                .substring(0,21)
              ),
              Image(
                image: AssetImage('assets/images/comment.png'),
                width: _mediaQuery.width * 0.8,
                height: _mediaQuery.height * 0.3,
              ),
              Text(
                "Détails",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: _separator,
              ),
              Row(
                children: [
                  Icon(
                    WeezlyIcon.card_plane,
                    color: WeezlyColors.blue3,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(thisColis.departure),
                  Icon(Icons.arrow_right_alt),
                  Text(thisColis.arrival),
                ],
              ),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.calendar2, "Date de départ : ",
                  thisColis.departureDate.toString().substring(0,10)),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.box, "Dimension : ", thisColis.dimension),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.kg, "Poids : ", thisColis.poids.toString()),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.ticket, "Montant : ",
                  thisColis.montant.toString() + "€"),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.delivery, "Transporteur : ", thisColis.deliverName),
              SizedBox(
                height: _separator,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Code de validation de livraison"),
                      Text(
                        thisColis.validationCode,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(WeezlyIcon.copy),
                ],
              ),
              SizedBox(
                height: _separator,
              ),
              Text("Copier et partager ce code au destinataire de votre colis,"
                  " mais attention ne communiquez pas ce code "
                  "au transporteur du colis"),
              SizedBox(
                height: _separator,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: _separator,
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: _separator,
              ),
              Text(thisColis.description),
              SizedBox(
                height: _separator,
              ),
              Row(
                children: [
                  Text("Statut : "),
                  thisColis.status == false ? Text("En cours") : Text("Terminé"),
                  thisColis.status == false
                      ? Icon(
                          Icons.circle,
                          color: WeezlyColors.yellow,
                        )
                      : Icon(
                          WeezlyIcon.check_circle,
                          color: WeezlyColors.green,
                        ),
                ],
              ),
              SizedBox(
                height: _separator + 20,
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  Text("Trouver de l'aide"),
                  SizedBox(
                    width: _separator,
                  ),
                  Icon(WeezlyIcon.help),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ColisAvis.routeName);
                },
                child: const Text('Mettre un avis'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
