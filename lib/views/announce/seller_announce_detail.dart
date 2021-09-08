import 'dart:ffi';

import 'package:baloogo/model/Announce.dart';
import 'package:baloogo/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../commons/weezly_colors.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/avatar.dart';
import '../../commons/weezly_icon_icons.dart';
import '../../widgets/contact.dart';

class SellerAnnounceDetail extends StatefulWidget {
  static const routeName = '/seller-announce-detail';

  @override
  _SellerAnnounceDetail createState() => _SellerAnnounceDetail();
}

class _SellerAnnounceDetail extends State<SellerAnnounceDetail> {
  String format(date) {
    String formattedDate = DateFormat.yMMMMd('fr_fr').format(date) +
        ' - ' +
        DateFormat.Hm('fr_fr').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final announce = ModalRoute.of(context)!.settings.arguments as Announce;
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
                Icon(WeezlyIcon.card_plane, color: WeezlyColors.blue3),
                SizedBox(width: 20),
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
              Text(announce.package.transportation.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            Divider(
              color: WeezlyColors.black,
            ),
            Row(children: [
              Icon(WeezlyIcon.calendar2, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: 5),
              Text("Date de départ : "),
              Text(format(announce.package.datetimeDeparture),
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(children: [
              Icon(WeezlyIcon.calendar2, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: 5),
              Text("Date d'arrivée : "),
              Text(format(announce.package.dateTimeArrival),
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(children: [
              Icon(WeezlyIcon.box, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: 5),
              Text("Dimensions : "),
              Text(announce.package.size.name,
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(children: [
              Icon(WeezlyIcon.kg, size: 20, color: WeezlyColors.blue3),
              SizedBox(width: 5),
              Text("Poids : "),
              Text(weight(announce.package.kgAvailable),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
            ]),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(WeezlyIcon.ticket, size: 20, color: WeezlyColors.blue3),
                SizedBox(width: 5),
                Text("Commission : "),
                Text(announce.propositionPrice.proposition.toStringAsFixed(0) + " €",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 10),
            Row(children: [
              Text("Description : ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 10),
            Row(children: [
              Flexible(
                  child:
                      Text(announce.package.description, textAlign: TextAlign.justify))
            ])
          ],
        ),
      ),
    );
  }

  String weight(double poids) {
    String weight = "";

    if (poids < 0.5) {
      weight = "0-500 g";
    }
    else if (poids < 1) {
      weight = "500 g - 1kg";
    } else {
      weight = "+ 1 kg";
    }

    return weight;
  }
}
