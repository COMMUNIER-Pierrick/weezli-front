import 'dart:convert';
import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/sizesList.dart';
import 'package:weezli/model/Announce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weezli/service/announce/deleteAnnounce.dart';
import 'package:weezli/views/orders/order_details.dart';
import '../../commons/weezly_colors.dart';
import '../../commons/weezly_icon_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AnnounceDetail extends StatefulWidget {
  static const routeName = '/seller-announce-detail';

  @override
  _AnnounceDetail createState() => _AnnounceDetail();
}

class _AnnounceDetail extends State<AnnounceDetail> {
  double widthSeparator = 20;

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Announce announce= arg['announce'];
    int idUser= arg['idUser'];
    //final TextEditingController _counterofferPriceCtrl = TextEditingController(text: announce.finalPrice.proposition.toString());
    String? sizes = sizesList(announce.package.size); //Fonction qui retourne une chaîne de caractères avec tous les éléments de la liste
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
            onPressed: () => Navigator.pushNamed(context, '/mes_annonces', arguments: idUser)),
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
                _viewImage(announce),
                SizedBox(height: 10),
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
                      Text(announce.price!.toString() + " €",
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
                //_counteroffer(announce, context, idUser),
                //_offer(announce, context, idUser, _counterofferPriceCtrl),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     //if (announce.idOrder != null) //S'il y a une commande sur cette annonce, on peut aller la voir.
                      TextButton (
                      onPressed: () async {
                      //var order = await findById(announce.idOrder!); //On récupère la commande pour l'envoyer à la route.

                      Navigator.pushNamed(context, OrderDetail.routeName, arguments: {
                        //'order': order,
                        'idUser': idUser
                      },);},
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
                      TextButton(
                        onPressed: () async {
                          var response = await deleteAnnounce(announce.id);
                          if (response.statusCode == 200)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Annonce supprimée !')),
                            );
                          Navigator.pushNamed(context, '/mes_annonces', arguments: idUser);
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

  // Afficher les images sur la page
  Widget _viewImage(Announce announce){
    if (announce.type == 1 && announce.imgUrl != ''){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            CarouselSlider.builder(
              itemCount: _listImage(announce).length,
              options: CarouselOptions(
                height: 170,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              itemBuilder: (context, index, realIndex) {
                final image = _listImage(announce)[index];
                return _buildImage(image);
              },
            ),
          SizedBox(height: 5),
          _buildIndicator(announce),
        ],
      );
    }else if(announce.type == 1 && announce.imgUrl == null) {
      return Container(
          alignment: Alignment.center,
          child:
          Image(
            image: AssetImage("assets/images/no_picture.png"),
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.15,
            fit: BoxFit.cover,
          )
      );
    }else{
      return Column();
    }
  }

  // Afficher une image dans mon caroussel
  Widget _buildImage(String image){
    return Container(
      color: Colors.grey,
      child: Image(
        image: NetworkImage('http://10.0.2.2:5000/images/' +
        image),
        width: MediaQuery.of(context).size.width * 0.70,
        height: MediaQuery.of(context).size.height * 0.15,
        fit: BoxFit.cover,
      ),
    );
  }

  // Indicateur de position sous les images
  Widget _buildIndicator(Announce announce) => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: _listImage(announce).length,
    effect: JumpingDotEffect(
      dotWidth: 10,
      dotHeight: 10,
    ),
  );

  //Récupération de la liste d'image
  _listImage(Announce announce) {
    List <String> listImage = announce.imgUrl!.split(",");
    return listImage;
  }
}

  /*Widget _order(Announce announce, BuildContext context, idUser, _counterofferPriceCtrl) {
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _counterofferPriceCtrl,
                  onTap: () => _counterofferPriceCtrl.clear(),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 122),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () => _createOrderOrCounteroffer(announce, context, idUser, _counterofferPriceCtrl),
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
                ),
                TextButton(
                  onPressed: () => _refusedCounteroffer(context, announce),
                  child: Text(
                    "REFUSER",
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
                Text(
                  "*Vous avez la possibiliter de faire une seule contre proposition en modifiant le prix avant de valider",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ]),
          ));
    } else
      return SizedBox(
        height: 0,
      );
  }

  Widget _counteroffer(Announce announce, BuildContext context, int idUser){

    if ((announce.transact == 1) && (announce.idOrder == null) && (announce.finalPrice.user.id != idUser) && (announce.finalPrice.accept == 2)) {
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
                    "Contre-proposition reçue de " +
                        announce.finalPrice.user.firstname! +
                        " " +
                        announce.finalPrice.user.lastname!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(announce.finalPrice.proposition.toString()),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () => _createOrder(announce, context, idUser),
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
                  ),
                  TextButton(
                    onPressed: () => _refusedCounteroffer(context, announce),
                    child: Text(
                      "REFUSER",
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
                ]),
          ));
    } else
      return SizedBox(
        height: 0,
      );
  }



  Widget _offer(Announce announce, BuildContext context, int idUser, _counterofferPriceCtrl){
    if ((announce.transact == 1) && (announce.idOrder == null) && (announce.finalPrice.user.id != idUser)) {
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _counterofferPriceCtrl,
                    onTap: () => _counterofferPriceCtrl.clear(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 122),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () => _createOrderOrCounteroffer(announce, context, idUser, _counterofferPriceCtrl),
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
                  ),
                  TextButton(
                    onPressed: () => _refusedCounteroffer(context, announce),
                    child: Text(
                      "REFUSER",
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
                  Text(
                    "*Vous avez la possibiliter de faire une seule contre proposition en modifiant le prix avant de valider",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ]),
          ));
    } else
      return SizedBox(
        height: 0,
      );
  }

  _createOrder(Announce announce, BuildContext context, int idUser) async {

    announce.finalPrice.accept = 1; // Proposition acceptée
    announce.price = announce.finalPrice.proposition; //Prix updaté
    Order order = Order(
        status: Status(id: 1, name: 'Payé'),
        dateOrder: DateTime.now(),
        user: announce.userAnnounce,
        // Vu que l'annonce part de l'expéditeur et donc du payeur, c'est lui qui est indiqué dans l'order.
        announce: announce,
        finalPrice: announce.finalPrice);
    var response = await createOrder(
        order); // Envoi de l'order au service et réception de la réponse
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Commande créée !')),
      );
      // On récupère le json renvoyé et on le convertit en objet order pour l'envoyer à la route.
      var mapOrder = OrdersListDynamic
          .fromJson(jsonDecode(response.body))
          .ordersListDynamic;
      Order newOrder = Order.fromJson(mapOrder);

      Navigator.pushNamed(context, OrderDetail.routeName, arguments: {
        'order': newOrder,
        'userId': idUser
      },); //newOrder
    }
  }

  _refusedCounteroffer(BuildContext context, Announce announce) async {
  // Modification de l'objet finalPrice et Announce à envoyer au back
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User? user = getUserInfo(
      prefs); //Vérifie si on a quelque chose en sharedpreferences (et donc si l'user est connecté). Le redirige vers le login sinon.
  if (user == null)
    Navigator.pushNamed(context, "/login");
  else {
    FinalPrice finalPrice = FinalPrice(
        id: announce.finalPrice.id, proposition: 0, accept: 0, user: user);
    var transact = 0;

    var response = await updateFinalPrice(announce.id!, finalPrice, transact);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proposition refusée !')),
      );
      Navigator.pushNamed(context, '/');
    }
  }

  _createOrderOrCounteroffer(Announce announce, BuildContext context, int idUser, TextEditingController priceController) async {
  // Création de l'objet order à envoyer au back
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User? user = getUserInfo(prefs);
  if (user == null)
    Navigator.pushNamed(context, "/login");

  else if (announce.finalPrice.proposition == double.parse(priceController.text)) {

    announce.finalPrice.accept = 1; // Proposition acceptée
    announce.price = announce.finalPrice.proposition; //Prix updaté
    Order order = Order(
        status: Status(id: 1, name: 'Payé'),
        dateOrder: DateTime.now(),
        user: announce.userAnnounce,
        // Vu que l'annonce part de l'expéditeur et donc du payeur, c'est lui qui est indiqué dans l'order.
        announce: announce,
        finalPrice: announce.finalPrice);
    var response = await createOrder(
        order); // Envoi de l'order au service et réception de la réponse
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Commande créée !')),
      );
      // On récupère le json renvoyé et on le convertit en objet order pour l'envoyer à la route.
      var mapOrder = OrdersListDynamic
          .fromJson(jsonDecode(response.body))
          .ordersListDynamic;
      Order newOrder = Order.fromJson(mapOrder);

      Navigator.pushNamed(context, OrderDetail.routeName, arguments: {
        'order': newOrder,
        'userId': idUser
      },); //newOrder
    }
  } else {
    var response = await updateFinalPrice(announce.id!);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contre-proposition envoyée !')),
      );
      Navigator.pushNamed(context, '/');
    }
  }
}
}*/