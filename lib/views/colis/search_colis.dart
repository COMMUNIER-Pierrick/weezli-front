import 'dart:developer';

import 'package:baloogo/commons/weezly_colors.dart';
import 'package:baloogo/commons/weezly_icon_icons.dart';
import 'package:baloogo/model/colis.dart';
import 'package:baloogo/service/colis/read_all.dart';
import 'package:baloogo/views/colis/colis_details.dart';
import 'package:flutter/material.dart';

class SearchColis extends StatefulWidget {
  const SearchColis({Key? key}) : super(key: key);
  static const String routeName = "/search-colis";

  @override
  _SearchColisState createState() => _SearchColisState();
}

class _SearchColisState extends State<SearchColis> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Colis>> colisFuture;
  List<Colis> colisList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colisFuture = readAllColis();
    inspect(colisFuture);
    ColisFutureToList();
  }
  ColisFutureToList(){
    colisFuture.then((value) {
      value.forEach((colis) { 
        setState(() {
          colisList.add(colis);
        });
      });
    });
  }
  //----------------------  Début brut  ----------------------------------------
  final List<Colis> _listColis = [
    Colis(
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
      status: false,
    ),
    Colis(
      id: 215545455,
      commandDate: '01-07-2021   15:21',
      departure: 'France',
      arrival: 'Italie',
      departureDate: DateTime.parse('1969-07-20 20:18:04Z'),
      dimension: 'Petit',
      poids: 0,
      montant: 17,
      deliverName: 'Melinda Rochel',
      validationCode: '25456',
      description: 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed non risus. Suspendisse lectus '
          'tortor, dignissim sit amet, adipiscing nec, '
          'ultricies sed, dolor. Cras '
          'elementum ultrices diam. Maecenas ligula massa, ',
      status: true,
    ),
    Colis(
      id: 215545456,
      commandDate: '01-07-2021   15:21',
      departure: 'France',
      arrival: 'Italie',
      departureDate: DateTime.parse('1969-07-20 20:18:04Z'),
      dimension: 'Petit',
      poids: 0,
      montant: 17,
      deliverName: 'Melinda Rochel',
      validationCode: '25456',
      description: 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit. Sed non risus. Suspendisse lectus '
          'tortor, dignissim sit amet, adipiscing nec, '
          'ultricies sed, dolor. Cras '
          'elementum ultrices diam. Maecenas ligula massa, ',
      status: true,
    ),
  ];
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

    GestureDetector _cardColis(Colis colis) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(context, ColisDetail.routeName),
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
              Row(
                children: [
                  Text(colis.departure),
                  Icon(Icons.arrow_right_alt),
                  Text(colis.arrival),
                  Spacer(),
                  Icon(
                    WeezlyIcon.arrow_right_square,
                    color: WeezlyColors.primary,
                  ),
                ],
              ),
              Divider(
                color: WeezlyColors.black,
              ),
              Text(
                "Description:",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                colis.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    WeezlyIcon.calendar2,
                    color: WeezlyColors.primary,
                  ),
                  Text(colis.commandDate),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Montant: ",
                          style: Theme.of(context).textTheme.headline5),
                      Text(colis.montant.toString() + "€"),
                    ],
                  ),
                  Row(
                    children: [
                      colis.status == false
                          ? Text("En cours")
                          : Text("Terminer"),
                      colis.status == false
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
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes colis"),
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
                  //for (Colis item in _listColis) _cardColis(item), //Version Brut
                  for (Colis item in colisList) _cardColis(item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
