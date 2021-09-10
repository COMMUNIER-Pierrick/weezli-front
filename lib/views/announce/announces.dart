import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/Formule.dart';
import 'package:weezli/model/Package.dart';
import 'package:weezli/model/Price.dart';
import 'package:weezli/model/PropositionPrice.dart';
import 'package:weezli/model/RIB.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Transportation.dart';
import 'package:weezli/model/Check.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/views/announce/announce_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Announces extends StatefulWidget {
  @override
  AnnouncesState createState() => AnnouncesState();

  static const routeName = '/mes_annonces';
}

class AnnouncesState extends State<Announces> {
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
  final List<Announce> _listTransporterAnnounce = [
    Announce(
      id: 215545454,
      package: Package(
          id: 132565,
          addressDeparture: Address(
              id: 12,
              number: 2,
              street: 'rue de Merville',
              zipCode: '59160',
              city: 'Rome'),
          addressArrival: Address(
              id: 45,
              number: 3,
              street: 'allée de la cour baleine',
              zipCode: '95500',
              city: 'Paris'),
          datetimeDeparture: DateTime.parse('2021-08-20 17:30:04Z'),
          dateTimeArrival: DateTime.parse('2021-08-21 08:30:04Z'),
          kgAvailable: 0.8,
          transportation: Transportation(id: 2, name: 'Avion'),
          description:
              "'Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          size: PackageSize(id: 1, name: 'Petit'),
          price: Price(
            id: 2,
            kgPrice: 50.0,
          )),
      propositionPrice: PropositionPrice(
          id: 2,
          proposition: 45,
          accept: true,
          sender: User(
              id: 2,
              firstname: 'Marie',
              lastname: "Corrales",
              username: 'Nino',
              email: 'noemie.contant@gmail.com',
              phone: '0627155307',
              active: true,
              rib: RIB(id: 5, name: 'RIB', IBAN: '46116465654'),
              urlProfilPicture: 'oiogdfpogkfdiojo',
              formule: Formule(
                  id: 1, name: 'Formule 1', description: 'Formule 1', price: 5),
              check: Check(
                  id: 1,
                  statusIdentity: true,
                  statusPhone: true,
                  imgIdCard: 'lkjgfùdfgùjdfg'))),
      views: 15,
      user: User(
          id: 1,
          firstname: 'Noémie',
          lastname: "Contant",
          username: 'STid',
          email: 'noemie.contant@gmail.com',
          phone: '0627155307',
          active: true,
          rib: RIB(id: 5, name: 'RIB', IBAN: '46116465654'),
          urlProfilPicture: 'oiogdfpogkfdiojo',
          formule: Formule(
              id: 1, name: 'Formule 1', description: 'Formule 1', price: 5),
          check: Check(
              id: 1,
              statusIdentity: true,
              statusPhone: true,
              imgIdCard: 'lkjgfùdfgùjdfg')),
    )
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

    GestureDetector _cardannounce(Announce announce) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(
            context, AnnounceDetail.routeName,
            arguments: announce),
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
                Text(announce.package.addressDeparture.city,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_right_alt),
                Text(announce.package.addressArrival.city,
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
                Text(format(announce.package.datetimeDeparture),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              Row(
                children: [
                  Text("Moyen de transport : ", style: TextStyle(fontSize: 15)),
                  Text(announce.package.transportation.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(children: [
                Text("Dimensions : ", style: TextStyle(fontSize: 15)),
                Text(announce.package.size.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
              ]),
              Row(
                children: [
                  Text("Commission : ", style: TextStyle(fontSize: 15)),
                  Text(
                      announce.propositionPrice.proposition.toStringAsFixed(0) +
                          " €",
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
                  for (Announce item in _listTransporterAnnounce)
                    _cardannounce(item), //Version Brut
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
