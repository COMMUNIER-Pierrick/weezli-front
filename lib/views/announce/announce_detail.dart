import 'dart:ffi';

import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weight.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/Check.dart';
import 'package:weezli/model/Formule.dart';
import 'package:weezli/model/Package.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Payment.dart';
import 'package:weezli/model/Transportation.dart';
import 'package:weezli/model/Type.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/announce/findById.dart';
import 'package:weezli/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../commons/weezly_colors.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/avatar.dart';
import '../../commons/weezly_icon_icons.dart';
import '../../widgets/contact.dart';

class AnnounceDetail extends StatefulWidget {
  static const routeName = '/seller-announce-detail';



  @override
  _AnnounceDetail createState() => _AnnounceDetail();
}

class _AnnounceDetail extends State<AnnounceDetail> {
  double widthSeparator = 20;

  Announce announce = Announce (
      id: 215545454,
      package: Package(
          id: 132565,
          addressDeparture: Address(
              id: 12,
              number: 2,
              street: 'rue de Merville',
              zipCode: '59160',
              city: 'Rome', name: 'Test'),
          addressArrival: Address(
              id: 45,
              number: 3,
              street: 'allée de la cour baleine',
              zipCode: '95500',
              city: 'Paris', name: 'Maison'),
          datetimeDeparture: DateTime.parse('2021-08-20 17:30:04Z'),
          dateTimeArrival: DateTime.parse('2021-08-21 08:30:04Z'),
          kgAvailable: 2,
          transportation: Transportation(id: 2, name: 'Avion'),
          description:
          "'Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          size: [PackageSize (id : 1, name : "Petit")],
          price: 50
      ),
      views: 15,
      userAnnounce: User(
          id: 1,
          firstname: 'Noémie',
          lastname: "Contant",
          username: 'STid',
          email: 'noemie.contant@gmail.com',
          phone: '0627155307',
          active: 1,
          payment: Payment(id: 5, name: 'RIB', IBAN: '46116465654'),
          urlProfilPicture: 'oiogdfpogkfdiojo',
          formule: Formule(
              id: 1, name: 'Formule 1', description: 'Formule 1', price: 5),
          check: Check(
              id: 1,
              statusIdentity: 1,
              statusPhone: 1,
              statusEmail : 1,
              imgIdCard: 'lkjgfùdfgùjdfg')),
      transact: 1,
      type: 1,
      price : 50,
    //idOrder: 1,
  );



  @override
  Widget build(BuildContext context) {
    //final announce = ModalRoute.of(context)!.settings.arguments as Announce;
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail"),
      ),
      body: Container(
        color: Color(0xE5E5E5),
        height: height * 0.9,
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(WeezlyIcon.card_plane,
                    color: WeezlyColors.blue3, size: 20),
                SizedBox(width: widthSeparator),
                Text(
                  announce.package.addressDeparture.city,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.arrow_right_alt),
                Text(
                  announce.package.addressArrival.city,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(children: [
              Text("Moyen de transport : "),
              Text(announce.package.transportation!.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            Divider(
              color: WeezlyColors.black,
            ),
            Row(children: [
              Icon(WeezlyIcon.calendar2, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: widthSeparator),
              Text("Date de départ : "),
              Text(format(announce.package.datetimeDeparture),
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(children: [
              Icon(WeezlyIcon.calendar2, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: widthSeparator),
              Text("Date d'arrivée : "),
              Text(format(announce.package.dateTimeArrival),
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(children: [
              Icon(WeezlyIcon.box, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: widthSeparator),
              Text("Dimensions : "),
              Text(announce.package.size.first.name,
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(children: [
              Icon(WeezlyIcon.kg, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: widthSeparator),
              Text("Poids : "),
              Text(weight(announce.package.kgAvailable),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            /*Row(
              children: [
                Icon(WeezlyIcon.ticket, size: 20, color: WeezlyColors.blue3),
                SizedBox(width: widthSeparator),
                Text("Commission de base : "),
                Text(
                    announce.price!.toStringAsFixed(0) +
                        " €",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ),*/
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.remove_red_eye_outlined,
                    size: 20, color: WeezlyColors.blue3),
                SizedBox(width: widthSeparator),
                Text("Nombre de vues : "),
                Text(announce.views.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ),
            _order(announce, context),
            SizedBox(height: 10),
            Row(children: [
              Text("Description : ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 10),
            Row(children: [
              Flexible(
                  child: Text(announce.package.description,
                      textAlign: TextAlign.justify))
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _order(Announce announce, BuildContext context) {
  if (announce.idOrder != null) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
        child: Container(
          padding : EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(16.0),
              color: WeezlyColors.grey1),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "Commande reçue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  "CONSULTER",
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
            ],
          ),
        ));
  } else
    return SizedBox(
      height: 0,
    );
}
