
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/commons/weezly_icon_icons.dart';
import 'package:weezli/model/Opinion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Opinions extends StatefulWidget {
  const Opinions({Key? key}) : super(key: key);

  @override
  _AvisState createState() => _AvisState();
}

class _AvisState extends State<Opinions> {
  final List<Opinion> list_opinions = [
    /*Opinion(
        id: 1,
        number: 5,
        comment: "Super livraison, très content !",
        order: Order(
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
                      city: 'Tourcoing'),
                  addressArrival: Address(
                      id: 45,
                      number: 3,
                      street: 'allée de la cour baleine',
                      zipCode: '95500',
                      city: 'Gonesse'),
                  datetimeDeparture: DateTime.parse('2021-08-20 17:30:04Z'),
                  dateTimeArrival: DateTime.parse('2021-08-21 08:30:04Z'),
                  kgAvailable: 0.8,
                  transportation: Transportation(id: 2, name: 'Avion'),
                  description:
                  "'Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  size: [PackageSize (id : 1, name : "Petit")],
                  price: Price(
                    id: 2,
                    kgPrice: 50.0,
                  )),
              finalPrice: FinalPrice(
                id: 2,
                proposition: 45,
                accept: true,
              ),
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
                      id: 1,
                      name: 'Formule 1',
                      description: 'Formule 1',
                      price: 5),
                  check: Check(
                      id: 1,
                      statusIdentity: true,
                      statusPhone: true,
                      imgIdCard: 'lkjgfùdfgùjdfg')),
              transact: true,
              price: 45,
              type: Type(id: 1, name: "Transport")),
          status: Status(
            id: 1,
            name: "En cours",
          ),
          validationCode: 2315,
          dateOrder: DateTime.parse('2021-07-20 17:30:04Z'),
          user: User(
              id: 2,
              firstname: 'Marie',
              lastname: "Corrales",
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
        )),
    Opinion(
        id: 2,
        number: 3,
        comment: "Colis un peu abimé, mais à part ça rien à dire.",
        order: Order(
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
                        city: 'Strasbourg'),
                    addressArrival: Address(
                        id: 45,
                        number: 3,
                        street: 'allée de la cour baleine',
                        zipCode: '95500',
                        city: 'Nice'),
                    datetimeDeparture: DateTime.parse('2021-08-20 17:30:04Z'),
                    dateTimeArrival: DateTime.parse('2021-08-21 08:30:04Z'),
                    kgAvailable: 0.8,
                    transportation: Transportation(id: 2, name: 'Avion'),
                    description:
                    "'Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    size: [PackageSize (id : 1, name : "Petit")],
                    price: Price(
                      id: 2,
                      kgPrice: 50.0,
                    )),
                finalPrice: FinalPrice(
                  id: 2,
                  proposition: 45,
                  accept: true,
                ),
                views: 15,
                transact: true,
                type: Type(id: 1, name: "Transport"),
                price: 45),
            status: Status(
              id: 1,
              name: "En cours",
            ),
            validationCode: 2315,
            dateOrder: DateTime.parse('2021-07-20 17:30:04Z'),
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
                    id: 1,
                    name: 'Formule 1',
                    description: 'Formule 1',
                    price: 5),
                check: Check(
                    id: 1,
                    statusIdentity: true,
                    statusPhone: true,
                    imgIdCard: 'lkjgfùdfgùjdfg')),
        )),
    Opinion(
        id: 2,
        number: 5,
        order: Order(
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
                        city: 'Strasbourg'),
                    addressArrival: Address(
                        id: 45,
                        number: 3,
                        street: 'allée de la cour baleine',
                        zipCode: '95500',
                        city: 'Nice'),
                    datetimeDeparture: DateTime.parse('2021-08-20 17:30:04Z'),
                    dateTimeArrival: DateTime.parse('2021-08-21 08:30:04Z'),
                    kgAvailable: 0.8,
                    transportation: Transportation(id: 2, name: 'Avion'),
                    description:
                    "'Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    size: [PackageSize (id : 2, name : "Moyen")],
                    price: Price(
                      id: 2,
                      kgPrice: 50.0,
                    )),
                finalPrice: FinalPrice(
                  id: 2,
                  proposition: 45,
                  accept: true,
                ),
                views: 15,
                transact: true,
                type: Type(id: 1, name: "Transport"),
                price: 45),
            status: Status(
              id: 1,
              name: "En cours",
            ),
            validationCode: 2315,
            dateOrder: DateTime.parse('2021-07-20 17:30:04Z'),
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
                    id: 1,
                    name: 'Formule 1',
                    description: 'Formule 1',
                    price: 5),
                check: Check(
                    id: 1,
                    statusIdentity: true,
                    statusPhone: true,
                    imgIdCard: 'lkjgfùdfgùjdfg')),
        )),*/
  ];

  @override
  Widget build(BuildContext context) {
    final Size _mediaQuery = MediaQuery
        .of(context)
        .size;
    Container _opinionCard(Opinion opinion) {
      return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                  radius: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opinion.order.user.firstname! +
                            " " +
                            opinion.order.user.lastname!,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            opinion
                                .order.announce.package.addressDeparture.city,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.arrow_right_alt),
                          Text(
                            opinion.order.announce.package.addressArrival.city,
                          ),
                        ],
                      ),
                      Text(opinion.comment ?? ""),
                      Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: WeezlyColors.yellow,
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              WeezlyIcon.star,
                              size: 10,
                            ),
                            Text(
                              opinion.number.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2,
              color: WeezlyColors.grey2,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Avis"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "John Doe",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline5,
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              width: _mediaQuery.width * 0.50,
              decoration: BoxDecoration(
                border: Border.all(color: WeezlyColors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(22.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Avis: ",
                    style: TextStyle(
                      color: WeezlyColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 4,
                    direction: Axis.horizontal,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: _mediaQuery.width < 321 ? 15 : 20,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
            ),
            Text(list_opinions.length.toString() + " avis"),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            for (Opinion opinion in list_opinions) _opinionCard(opinion)
          ],
        ),
      ),
    );
  }
}
