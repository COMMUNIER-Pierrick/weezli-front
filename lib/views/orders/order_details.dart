import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/commons/weight.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/service/colis/read_one.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final order = ModalRoute.of(context)!.settings.arguments as Order;

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
              mix(WeezlyIcon.calendar2, "Date de départ : ",
                  format(order.announce.package.datetimeDeparture)),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.box, "Dimension : ",
                  order.announce.package.size.first.name),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.kg, "Poids : ",
                  weight(order.announce.package.kgAvailable)),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.ticket, "Montant : ",
                  order.announce.price!.toStringAsFixed(0) + "€"),
              SizedBox(
                height: _separator,
              ),
              mix(WeezlyIcon.delivery, "Transporteur : ",
                  order.user.firstname! + " " + order.user.lastname!),
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
              Text(
                  "Code à transmettre au destinaire du colis uniquement",
              style: TextStyle (
                fontSize: 12,
              )),
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
              Text(order.announce.package.description),
              SizedBox(
                height: _separator,
              ),
              Row(
                children: [
                  Text("Statut : "),
                  order.status.name == 'Payé'
                      ? Text("Payé")
                      : Text("Terminé"),
                  order.status.name == 'En cours'
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
                height: _separator,
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
              _opinion(order, context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _opinion(Order order, BuildContext context) {
  if (order.status.name == "Terminé")
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, ColisAvis.routeName);
        },
        child: const Text('Mettre un avis'));
  else
    return SizedBox(
      height: 0,
    );
}
