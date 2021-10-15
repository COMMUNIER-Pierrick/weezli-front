import 'package:weezli/model/Address.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/Check.dart';
import 'package:weezli/model/FinalPrice.dart';
import 'package:weezli/model/Formule.dart';
import 'package:weezli/model/Package.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Payment.dart';
import 'package:weezli/model/Transportation.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/views/announce/search_announce_detail.dart';
import 'package:weezli/widgets/avatar.dart';
import 'package:weezli/widgets/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CardItem extends StatelessWidget {
  final searchValues;
  CardItem(this.searchValues);

  Announce announce = Announce(
    id: 215545454,
    package: Package(
      id: 132565,
      addressDeparture: Address(
          id: 12,
          number: 2,
          street: 'rue de Merville',
          zipCode: '59160',
          city: 'France', name: 'maison'),
      addressArrival: Address(
          id: 45,
          number: 3,
          street: 'allée de la cour baleine',
          zipCode: '95500',
          city: 'Madagascar', name: 'Chez les vieux'),
      datetimeDeparture: DateTime.parse('2021-08-20 17:30:04Z'),
      dateTimeArrival: DateTime.parse('2021-08-21 08:30:04Z'),
      kgAvailable: 1,
      transportation: Transportation(id: 2, name: 'Avion'),
      description:
      "'Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      size: [PackageSize (id : 1, name : "Petit")],
    ),
    views: 15,
    userAnnounce: User(
        id: 1,
        firstname: 'Mélinda',
        lastname: "Rachel",
        username: 'Mélinda',
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
            imgIdCard: 'lkjgfùdfgùjdfg'),
        moyenneAvis: 4),

    type: 2,
    transact: 0,
    price: 60, dateCreated: new DateTime.now(), finalPrice: FinalPrice (
    user: User (
      firstname: 'Noémie',
      lastname: 'Contant'
    ),
    proposition: 30,
    accept: 1
  ),

    //idOrder: 1,
  );

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SearchAnnounceDetail.routeName, arguments: announce),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(10),
        width: 1000, //MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            contact(),
            SizedBox(
              width: 20,
            ),
            packageInformations(),
            Spacer(),
            price(),
          ],
        ),
      ),
    );
  }

  Widget contact() {
    return Column(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(30),
        //SizedBox(height: 10,),
        Contact(),
      ],
    );
  }

  Widget packageInformations() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Melinda",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900]),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 12,
                  ),
                  Text(
                    "4",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Text(
          "Dimension: Petit",
          style: TextStyle(fontSize: 14, color: Colors.indigo[900]),
        ),
        Text(
          "Poids: 0-500 g",
          style: TextStyle(fontSize: 14, color: Colors.indigo[900]),
        ),
        Row(
          children: [
            Text(
              "France",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.indigo[900],
                  fontWeight: FontWeight.w500),
            ),
            Icon(Icons.arrow_right_alt),
            Text(
              "Madagascar",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.indigo[900],
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget price() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        searchValues['type'] == 'sending' ? sendIcon() : carryIcon(),
        Text.rich(TextSpan(
            text: "100",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900]),
            children: [
              TextSpan(
                text: "€",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900]),
              )
            ]))
      ],
    );
  }

  Widget sendIcon() {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: SvgPicture.asset(
        "assets/images/svg/send.svg",
        color: Colors.white,
      ),
    );
  }

  Widget carryIcon() {
    return CircleAvatar(
      backgroundColor: Colors.amber,
      child: SvgPicture.asset("assets/images/svg/delivery.svg"),
    );
  }
}
