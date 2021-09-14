import 'dart:developer';

import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Address.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/Check.dart';
import 'package:weezli/model/Formule.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/Package.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Price.dart';
import 'package:weezli/model/PropositionPrice.dart';
import 'package:weezli/model/RIB.dart';
import 'package:weezli/model/Status.dart';
import 'package:weezli/model/Transportation.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/colis/read_all.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'delivery_details.dart';

class SearchDeliveries extends StatefulWidget {
  const SearchDeliveries({Key? key}) : super(key: key);
  static const String routeName = "/search-deliveries";

  @override
  _SearchDeliveriesState createState() => _SearchDeliveriesState();
}

class _SearchDeliveriesState extends State<SearchDeliveries> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Announce>> announceFuture;

  /* List<Announce> announceList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    announceFuture = readAllPackages();
    inspect(announceFuture);
    AnnounceFutureToList();
  }
  AnnounceFutureToList(){
    announceFuture.then((value) {
      value.forEach((announce) {
        setState(() {
          announceList.add(announce);
        });
      });
    });
  }*/
  //----------------------  Début brut  ----------------------------------------
  final List<Order> _listOrders = [
    Order(
      id: 215545454,
      announce: Announce(
        id: 233123,
        package: Package(
            id: 132565,
            addressDeparture: Address(
                id: 12,
                number: 2,
                street: 'rue de Merville',
                zipCode: '59160',
                city: 'Nantes'),
            addressArrival: Address(
                id: 45,
                number: 3,
                street: 'allée de la cour baleine',
                zipCode: '95500',
                city: 'Dakar'),
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
                    id: 1,
                    name: 'Formule 1',
                    description: 'Formule 1',
                    price: 5),
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
      ),
      status: Status(
        id: 1,
        name: "En cours",
      ),
      validationCode: 2315,
      dateOrder: DateTime.parse('2021-08-05 17:30:04Z'),
    )
  ];

  //----------------------  Fin   brut  ----------------------------------------
  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery
        .of(context)
        .size;
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

    GestureDetector _cardOrder(Order order) {
      return GestureDetector(
        onTap: () => Navigator.pushNamed(
            context, DeliveryDetail.routeName,
            arguments: order),
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
                  Text(order.announce.package.addressDeparture.city),
                  Icon(Icons.arrow_right_alt),
                  Text(order.announce.package.addressArrival.city),
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              Text(
                order.announce.package.description,
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(format(order.announce.package.datetimeDeparture)),
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5),
                      Text(
                        order.announce.propositionPrice!.proposition.toStringAsFixed(
                            0) + "€",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(order.status.name),
                      order.status.name == "En cours"
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
        ),);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mes livraisons"),
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
                  for (Order item in _listOrders) _cardOrder(item),
                  //Version Brut
                  //for (Announce item in announceList) _cardAnnounce(item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}