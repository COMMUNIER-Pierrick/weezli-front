import 'package:weezli/commons/format.dart';
import 'package:weezli/model/Announce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/PackageSize.dart';
import 'package:weezli/model/Status.dart';
import 'package:weezli/service/announce/deleteAnnounce.dart';
import 'package:weezli/service/order/createOrder.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:weezli/views/orders/order_details.dart';
import 'package:weezli/service/order/findById.dart';
import 'package:weezli/views/orders/order_details.dart';
import '../../commons/weezly_colors.dart';
import '../../commons/weezly_icon_icons.dart';

class AnnounceDetail extends StatefulWidget {
  static const routeName = '/seller-announce-detail';

  @override
  _AnnounceDetail createState() => _AnnounceDetail();
}

class _AnnounceDetail extends State<AnnounceDetail> {
  double widthSeparator = 20;

  @override
  Widget build(BuildContext context) {
    final announce = ModalRoute
        .of(context)!
        .settings
        .arguments as Announce;
    String? sizes;
    for (PackageSize size in announce.package.size) {
      if (sizes != null)
        sizes = sizes + ", " + size.name;
      else
        sizes = size.name;
    }
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    final width = (mediaQuery.size.width);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, '/mes_annonces')),
        title: Text("Détail"),
      ),
      body: Container(
          color: Color(0xE5E5E5),
          height: height * 0.9,
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
          child: SingleChildScrollView(
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
                if (announce.type == 2)
                  Row(children: [
                    Text("Moyen de transport : "),
                    Text(announce.package.transportation!.name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                Divider(
                  color: WeezlyColors.black,
                ),
                Row(children: [
                  Icon(WeezlyIcon.calendar2,
                      size: 20, color: WeezlyColors.blue3),
                  SizedBox(width: widthSeparator),
                  Text(announce.type == 2
                      ? "Date de départ : "
                      : "Date limite : "),
                  Text(format(announce.package.datetimeDeparture),
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 10),
                if (announce.type == 2)
                  Row(children: [
                    Icon(WeezlyIcon.calendar2,
                        size: 20, color: WeezlyColors.blue3),
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
                  Text(sizes!, style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 10),
                Row(children: [
                  Icon(WeezlyIcon.kg, size: 20, color: WeezlyColors.blue3),
                  SizedBox(width: widthSeparator),
                  Text("Poids : "),
                  Text(announce.package.kgAvailable.toString() + " kg",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 10),
                if (announce.type == 2)
                  Row(
                    children: [
                      Icon(WeezlyIcon.ticket,
                          size: 20, color: WeezlyColors.blue3),
                      SizedBox(width: widthSeparator),
                      Text("Commission de base : "),
                      Text(announce.price!.toStringAsFixed(0) + " €",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                    ],
                  ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined,
                        size: 20, color: WeezlyColors.blue3),
                    SizedBox(width: widthSeparator),
                    Text("Nombre de vues : "),
                    Text(announce.views.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))
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
                if (announce.type == 1 && announce.imgUrl != '')
                  Column(
                    children: [
                      Text("Photos : ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      for(int i = 0; i <= 4; i++) _image(announce, i), // Affiche chaque image de la liste d'image
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (announce.idOrder != null)
                      TextButton (
                      onPressed: () async {
                      var order = await findById(announce.idOrder!);

                      Navigator.pushNamed(context, OrderDetail.routeName, arguments: order.id);
                      },
                      child: Text(
                        "DETAIL DE LA COMMANDE",
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
                      SizedBox(height: 10),
                      if (announce.transact == 0)
                      TextButton(
                        onPressed: () async {
                          var response = await deleteAnnounce(announce.id);
                          if (response.statusCode == 200)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Annonce supprimée !')),
                            );
                          Navigator.pushNamed(context, '/mes_annonces');
                        },
                        child: Text(
                          "SUPPRIMER L'ANNONCE",
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
                    )]
                  ),
            ]),
          )),
    );
  }

  //Récupération de la liste d'image
  _listImage(Announce announce) {
    if (announce.imgUrl != '') {
      List <String> listImage = announce.imgUrl!.split(",");
      return listImage;
    }
  }

  // Affichage d'une image dans la liste d'image
  _image(Announce announce, int number) {
    List <String> listImage = _listImage(announce);
    print("$listImage");
    if (number <= listImage.length - 1) {
      return Column(
          children: [
            Image(
                image: NetworkImage('http://10.0.2.2:5000/images/' +
                    listImage[number])),
            SizedBox(height: 10)
          ]
      );
    }
    return Column(
        children:[]
    );
  }
}

  Widget _order(Announce announce, BuildContext context) {
    if ((announce.transact == 1) && (announce.idOrder == null)) {
      return Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: WeezlyColors.grey1),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Proposition reçue de " +
                      announce.finalPrice.user.firstname! +
                      " " +
                      announce.finalPrice.user.lastname!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(announce.finalPrice.proposition.toString() + " €"),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () => _createOrder(announce, context),
                  child: Text(
                    "VALIDER",
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

_createOrder(Announce announce, BuildContext context) async {
  announce.finalPrice.accept = 1;
  announce.price = announce.finalPrice.proposition;
  Order order = Order(
      status: Status(id: 1, name: 'Payé'),
      dateOrder: DateTime.now(),
      user: announce.userAnnounce,
      announce: announce,
      finalPrice: announce.finalPrice);
  var response = await createOrder(order);
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Commande créée !')),
    );
    var mapOrder = OrdersListDynamic.fromJson(jsonDecode(response.body)).ordersListDynamic;
    Order newOrder = Order.fromJson(mapOrder);

    Navigator.pushNamed(context, OrderDetail.routeName, arguments: newOrder); //newOrder
  }
}
