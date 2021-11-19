import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Order.dart';
import 'package:flutter/material.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/views/account/profile.dart';
import 'package:weezli/views/announce/announce_detail.dart';

import 'colis_avis.dart';

class OrderDetail extends StatefulWidget {
  @override
  OrderDetailState createState() => OrderDetailState();

  static const routeName = '/colis-details';
}

class OrderDetailState extends State<OrderDetail> {

  double _separator = 15;

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Order order= arg['order'];
    int idUser= arg['idUser'];

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
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, Profile.routeName)),
        title: Text(order.announce.package.addressDeparture.city +
            " - " +
            order.announce.package.addressArrival.city),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("N° de commande : " + order.id.toString()),
              Text("Du : " + format(order.dateOrder)),
              Image(
                image: AssetImage('assets/images/comment.png'),
                width: _mediaQuery.width * 0.8,
                height: _mediaQuery.height * 0.2,
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
                  Text(order.announce.package.addressDeparture.city),
                  Icon(Icons.arrow_right_alt),
                  Text(order.announce.package.addressArrival.city),
                ],
              ),
              SizedBox(
                height: _separator,
              ),
              Row(
                children: [
                  Icon(
                    WeezlyIcon.calendar2,
                    color: WeezlyColors.blue3,
                  ),
                  SizedBox(
                    width: _separator + 10,
                  ),
                  Text("Date de départ : "),
                  Text(format(order.announce.package.datetimeDeparture),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )
                    //Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              SizedBox(
                height: _separator,
              ),
              Row(
                children: [
                  Icon(
                    WeezlyIcon.box,
                    color: WeezlyColors.blue3,
                  ),
                  SizedBox(
                    width: _separator + 10,
                  ),
                  Text("Dimension : "),
                  Text(_listSize(order),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )
                      //Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.kg, "Poids : ",
                  order.announce.package.kgAvailable.toString() + " kg"),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.ticket, "Montant : ",
                  order.announce.price.toString() + "€"),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.delivery, "Transporteur : ",
                  order.announce.userAnnounce.firstname! + " " + order.announce.userAnnounce.lastname!
                ),
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
                        order.validationCode.toString(),
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
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _status(order.status.name)
                ],
              ),
              SizedBox(
                height: _separator,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, AnnounceDetail.routeName, arguments: {'idUser': idUser, 'announce': order.announce}),
                      child: Text(
                        "VOIR L'ANNONCE",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                        backgroundColor: WeezlyColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                      ),
                    ),
                  ]
              ),
              Divider(
                thickness: 2,
              ),
              _affichageAvis(_mediaQuery, order, context, idUser),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Trouver de l'aide"),
                  SizedBox(
                    width: _separator,
                  ),
                  Icon(WeezlyIcon.help),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _affichageAvis(_mediaQuery, order, context, idUser) {
  if (order.status.name == "Terminé") { //&& order.opinion.status == "Active"
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Avis",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline5,
                ),
              ]),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 0,
                //order.opinion.number
                minRating: 1,
                direction: Axis.horizontal,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: _mediaQuery.width < 321
                    ? 15
                    : 20,
                itemPadding:
                EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) =>
                    Icon(
                      Icons.star,
                      color: WeezlyColors.yellow,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("order.opinion.comment"),
            ],
          ),
          SizedBox(height: 5),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, ColisAvis.routeName,
                          arguments: {'order': order, 'idUser': idUser}),
                  child: Text(
                    "MODIFIER",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    backgroundColor: WeezlyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                  ),
                )
              ]),
          SizedBox(height: 5),
          Divider(
            thickness: 2,
          ),
        ]);
  } else {
    return Column(
      children: [
        _opinion(order, context, idUser),
      ],
    );
  }
}


_listSize(Order order){
  String? sizes;
  for ( PackageSize size in order.announce.package.size) {
    if (sizes != null)
      sizes = sizes + ", " + size.name;
    else
      sizes = size.name;
  }
  return sizes;
}

Widget _opinion(Order order, BuildContext context, int idUser) {
  if (order.status.name == "Terminé") {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ColisAvis.routeName,
                    arguments: {'order': order, 'idUser': idUser});
              },
              child: const Text('METTRE UN AVIS',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                backgroundColor: WeezlyColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.5),
                ),
              ),
            ),
          ],
        ),
        Divider(thickness: 2),
      ],
    );
  }else
    return Row();
}

_status(String statut){
  if(statut == "En cours"){
    return Row(
        children: [
          Row(children: [
            Icon(
              Icons.circle,
              color: WeezlyColors.yellow,
            ),
            SizedBox(width: 10),
            Text(statut),
          ]
          )]
    );
  }else if (statut == "Livré"){
    return Row(
        children: [
          Row(children: [
            Icon(
              Icons.circle,
              color: WeezlyColors.orange,
            ),
            SizedBox(width: 10),
            Text(statut),
          ]
          )]
    );
  }else if (statut == "Terminé"){
    return Row(
        children: [
          Row(children: [
            Icon(
              Icons.circle,
              color: WeezlyColors.green,
            ),
            SizedBox(width: 10),
            Text(statut),
          ]
          )]
    );
  }
}
