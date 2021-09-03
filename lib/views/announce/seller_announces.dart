import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:baloogo/model/announce.dart';
import 'package:baloogo/views/announce/seller_announce_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellerAnnounces extends StatefulWidget {
  @override
  SellerAnnouncesState createState() => SellerAnnouncesState();

  static const routeName = '/mes_annonces';
}

class SellerAnnouncesState extends State<SellerAnnounces> {
  final TextEditingController _searchController = TextEditingController();

  /*late Future<List<Announce>> announceFuture;
  List<Announce> announceList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    announceFuture = readAllAnnounces();
    inspect(announceFuture);
    announceFutureToList();
  }
  announceFutureToList(){
    announceFuture.then((value) {
      value.forEach((announce) {
        setState(() {
          announceList.add(announce);
        });
      });
    });
  }*/
  //----------------------  Début brut  ----------------------------------------
  final List<Announce> _listAnnounces = [
    Announce(
      id: 215545454,
      commandDate: '01-07-2021   15:21',
      departure: 'France',
      arrival: 'Madagascar',
      departureDate: DateTime.parse('2021-07-30 20:18:04Z'),
      arrivalDate: DateTime.parse('2021-07-30 22:18:04Z'),
      dimension: 'Petit',
      travelMode: 'Avion',
      poids: 0.7,
      montant: 70,
      views: 15,
      description: 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed non risus. Suspendisse lectus '
          'tortor, dignissim sit amet, adipiscing nec, '
          'ultricies sed, dolor. Cras '
          'elementum ultrices diam. Maecenas ligula massa, ',
      status: true,
    ),
    Announce(
      id: 215545455,
      commandDate: '01-07-2021   15:21',
      departure: 'France',
      arrival: 'Italie',
      departureDate: DateTime.parse('2021-08-20 17:30:04Z'),
      arrivalDate: DateTime.parse('2021-08-21 08:30:04Z'),
      dimension: 'Grand',
      travelMode: 'Avion',
      poids: 1.5,
      montant: 17,
      description: 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed non risus. Suspendisse lectus '
          'tortor, dignissim sit amet, adipiscing nec, '
          'ultricies sed, dolor. Cras '
          'elementum ultrices diam. Maecenas ligula massa, ',
      views: 12,
      status: true,
    ),
    Announce(
      id: 215545456,
      commandDate: '01-07-2021   15:21',
      departure: 'France',
      arrival: 'Italie',
      departureDate: DateTime.parse('2021-09-15 11:15:04Z'),
      arrivalDate: DateTime.parse('2021-09-15 14:00:04Z'),
      dimension: 'Petit',
      travelMode: 'Avion',
      poids: 0.3,
      montant: 40,
      views: 5,
      description: 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed non risus. Suspendisse lectus '
          'tortor, dignissim sit amet, adipiscing nec, '
          'ultricies sed, dolor. Cras '
          'elementum ultrices diam. Maecenas ligula massa, ',
      status: true,
    ),
  ];

  String format(date) {
    String formattedDate = DateFormat.yMMMMd('fr_fr').format(date) +
        ' - ' +
        DateFormat.Hm('fr_fr').format(date);
    return formattedDate;
  }

  //----------------------  Fin   brut  ----------------------------------------
  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery.of(context).size;
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

    GestureDetector _cardAnnounce(Announce announce) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, SellerAnnounceDetail.routeName, arguments: announce),
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          width: _mediaQuery.width,
          decoration: BoxDecoration(
            color: WeezlyColors.grey1,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(announce.departure,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_right_alt),
                Text(announce.arrival,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(
                  WeezlyIcon.arrow_right_square,
                  color: WeezlyColors.primary,
                ),
              ]),
              Divider(
                color: WeezlyColors.black,
              ),
              Row(children: [
                Icon(WeezlyIcon.calendar2, size: 15),
                SizedBox(width: 5),
                Text("Date de départ : "),
                Text(format(announce.departureDate),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              Row(
                children: [
                  Text("Moyen de transport : ", style: TextStyle(fontSize: 15)),
                  Text(announce.travelMode,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(children: [
                Text("Dimensions : ", style: TextStyle(fontSize: 15)),
                Text(announce.dimension,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ]),
              Row(
                children: [
                  Text("Commission : ", style: TextStyle(fontSize: 15)),
                  Text(announce.montant.toStringAsFixed(0) + " €",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes annonces"),
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
              child: Column(
                children: [
                  for (Announce item in _listAnnounces)
                    _cardAnnounce(item), //Version Brut
                  //for (Colis item in announceList) _cardColis(item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
