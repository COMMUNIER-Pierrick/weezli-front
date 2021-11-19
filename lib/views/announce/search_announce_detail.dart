import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weezli/commons/format.dart';
import 'package:weezli/commons/sizesList.dart';
import 'package:weezli/commons/weezly_colors.dart';
import 'package:weezli/model/Announce.dart';
import 'package:weezli/model/Order.dart';
import 'package:weezli/model/Proposition.dart';
import 'package:weezli/model/StatusProposition.dart';
import 'package:weezli/model/user.dart';
import 'package:weezli/service/proposition/createProposition.dart';
import 'package:weezli/service/statusProposition/findStatusPropositionById.dart';
import 'package:weezli/service/user/getUserInfo.dart';
import 'package:weezli/views/account/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weezli/views/orders/order_details.dart';
import '../../commons/weezly_colors.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/avatar.dart';
import '../../commons/weezly_icon_icons.dart';
import '../../widgets/contact.dart';

//Classe qui permet de faire un widget dynamique et appelle la classe qui fait le build

class SearchAnnounceDetail extends StatefulWidget {
  static const routeName = '/search-announce-detail';

  @override
  _SearchAnnounceDetail createState() => _SearchAnnounceDetail();
}

class _SearchAnnounceDetail extends State<SearchAnnounceDetail> {

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height - appBar.preferredSize.height -
        mediaQuery.padding.top);
    final arg = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    Announce announce = arg['announce'];
    User user = arg['user'];
    String? sizes = sizesList(announce.package.size);
    final TextEditingController _offerPriceCtrl = TextEditingController(
        text: announce.price.toString());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: WeezlyColors.white),
              onPressed: () => Navigator.pushNamed(context, '/')),
          title: Text("Détail"),
        ),
        body: Container(
            color: Color(0xE5E5E5),
            height: height * 0.9,
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 10),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _viewImage(announce),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Avatar(40),
                          SizedBox(width: 10),
                          Container(
                            // height: 80,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, UserProfile.routeName,
                                        arguments:
                                        announce.userAnnounce.id);
                                  },
                                  child: CustomTitle(announce
                                      .userAnnounce.firstname! +
                                      " " +
                                      announce.userAnnounce.lastname!),
                                ),
                                Contact(),
                                SizedBox(height: 2),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 0),
                                  decoration: announce.type == 1
                                      ? BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius:
                                    BorderRadius.only(
                                      bottomRight:
                                      Radius.circular(40),
                                      topRight:
                                      Radius.circular(40),
                                    ),
                                  )
                                      : BoxDecoration(
                                    color: WeezlyColors.blue3,
                                    borderRadius:
                                    BorderRadius.only(
                                      bottomRight:
                                      Radius.circular(40),
                                      topRight:
                                      Radius.circular(40),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      announce.type == 2
                                          ? Row(children: [
                                        Icon(WeezlyIcon.delivery),
                                        SizedBox(width: 4),
                                        CustomTitle(
                                          "Transporteur",
                                        )
                                      ])
                                          : Row(children: [
                                        Icon(
                                            WeezlyIcon
                                                .paper_plane_empty,
                                            color: Colors.white,
                                            size: 15),
                                        SizedBox(width: 6),
                                        CustomTitle("Colis")
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitle("Détail"),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(WeezlyIcon.card_plane,
                                    color: WeezlyColors.blue3,
                                    size: 20),
                                SizedBox(width: 12),
                                Text(
                                  announce
                                      .package.addressDeparture.city,
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
                            SizedBox(height: 10),
                            if (announce.type == 2)
                              Row(
                                children: [
                                  Icon(WeezlyIcon.calendar2,
                                      color: WeezlyColors.blue3),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      _buildCustomText(
                                          context,
                                          "Date de départ : ",
                                          format(announce.package
                                              .datetimeDeparture)),
                                      _buildCustomText(
                                          context,
                                          "Date d'arrivée : ",
                                          format(announce.package
                                              .dateTimeArrival)),
                                      SizedBox(height: 10),
                                    ],
                                  )
                                ],
                              ),
                            _buildRow(context, WeezlyIcon.box,
                                "Dimensions : ", sizes!),
                            SizedBox(height: 10),
                            _buildRow(
                              context,
                              WeezlyIcon.kg,
                              "Poids : ",
                              announce.package.kgAvailable.toString() +
                                  " kg",
                            ),
                            SizedBox(height: 10),
                            if (announce.type == 2)
                              _buildRow(
                                  context,
                                  WeezlyIcon.ticket,
                                  "Commission : ",
                                  announce.price!.toStringAsFixed(2) + " €"),
                            SizedBox(height: 10),
                            _buildRow(
                              context,
                              Icons.remove_red_eye_outlined,
                              "Nombre de vues : ",
                              announce.views.toString(),
                            ),
                            Divider(thickness: 2),
                            SizedBox(height: 10),
                            CustomTitle("A propos"),
                            SizedBox(height: 10),
                            Text(
                              announce.package.description,
                              textAlign: TextAlign.left,
                              style: TextStyle(height: 1.3),
                            ),
                            SizedBox(height: 10),
                            Divider(thickness: 2),
                            if (user.id != announce.userAnnounce.id)
                            Container(
                              margin: EdgeInsets.all(5),
                              height: height * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)
                                ),
                                color: WeezlyColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.26),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset:
                                    Offset(0, 1), // changes position of shadow
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                    Text(
                                      announce.price!.toString() + " €",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                ElevatedButton(
                                    onPressed: () =>
                                        _contact(announce, user.id!,
                                            _offerPriceCtrl),
                                    child: Text(
                                      "Contacter".toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 50),
                                      primary: Theme
                                          .of(context)
                                          .buttonColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25)),
                                    ))
                              ]),
                        )
                    ]
                )
            )
        ])
    )));
  }

  // Afficher les images sur la page
  Widget _viewImage(Announce announce) {
    if (announce.type == 1 && announce.imgUrl != '') {
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
    } else if (announce.type == 1 && announce.imgUrl == null) {
      return Container(
          alignment: Alignment.center,
          child:
          Image(
            image: AssetImage("assets/images/no_picture.png"),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.50,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.15,
            fit: BoxFit.cover,
          )
      );
    } else {
      return Column();
    }
  }

  // Afficher une image dans mon caroussel
  Widget _buildImage(String image) {
    return Container(
      color: Colors.grey,
      child: Image(
        image: NetworkImage('http://10.0.2.2:5000/images/' +
            image),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.70,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.15,
        fit: BoxFit.cover,
      ),
    );
  }

  // Indicateur de position sous les images
  Widget _buildIndicator(Announce announce) =>
      AnimatedSmoothIndicator(
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

  RichText _buildCustomText(BuildContext context, String firstText,
      String secondText) {
    return RichText(
      text: TextSpan(
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        children: [
          TextSpan(text: firstText),
          TextSpan(
            text: secondText,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Row _buildRow(BuildContext context, IconData icon, String firstText,
      String secondText) {
    return Row(
      children: [
        Icon(icon, color: WeezlyColors.blue3),
        SizedBox(width: 12),
        _buildCustomText(context, firstText, secondText)
      ],
    );
  }

  _contact(Announce announce, int idUser,
      TextEditingController _offerPriceCtrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(
        prefs); //Vérifie si on a quelque chose en sharedpreferences (et donc si l'user est connecté). Le redirige vers le login sinon.
    if (user == null)
      Navigator.pushNamed(context, "/login");
    else {
      String buttonTitle = "Proposition";
      String text = "*Vous avez la possibiliter de faire une seule proposition en modifiant le prix avant de valider";
      showDialog(
          context: context, builder: (BuildContext context) {
        return _buildPopupOffer(
            context,
            announce,
            announce.price,
            buttonTitle,
            text,
            user,
            idUser,
            _offerPriceCtrl
        );
      });
    }
  }

  Widget _buildPopupOffer(BuildContext context, Announce announce,
      num? price, String buttonTitle, String text, User user, int idUser,
      TextEditingController _offerPriceCtrl) {
    return new Dialog(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .width * 0.7,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomTitle(buttonTitle)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  child: TextFormField(
                    controller: _offerPriceCtrl,
                    onTap: () => _offerPriceCtrl.clear(),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.euro),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  height: 35,
                  child: RawMaterialButton(
                    fillColor: WeezlyColors.white,
                    textStyle: TextStyle(
                      color: WeezlyColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.5),
                        side: BorderSide(color: WeezlyColors.primary)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ANNULER"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  height: 35,
                  child: RawMaterialButton(
                    fillColor: WeezlyColors.primary,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    onPressed: () =>
                        _createOrderOrOffer(
                            announce, context, idUser, _offerPriceCtrl),
                    child: const Text("VALIDER"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LimitedBox(
                    maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _createOrderOrOffer(Announce announce, BuildContext context, int idUser,
      TextEditingController priceController) async {
    // Récupération du statusProposition
    StatusProposition statusPropositionValider = await findStatusPropositionById(
        3);

    // Récupération du statusProposition contre-proposition
    StatusProposition statusPropositionProposition = await findStatusPropositionById(
        1);

    // Vérification si l'utilisateur est bien connecter
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User? user = getUserInfo(prefs);
    if (user == null) {
      Navigator.pushNamed(context, "/login");
    }else if (announce.price == int.parse(priceController.text)) {
      // Création de l'objet proposition à envoyer au back
      Proposition proposition = Proposition(
        announce: announce,
        userProposition: user,
        proposition: announce.price,
        statusProposition: statusPropositionValider,
      );
      var response = await createProposition(proposition);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Commande créée !')),
        );
        var mapOrder = OrdersListDynamic
            .fromJson(jsonDecode(response.body))
            .ordersListDynamic;
        Order newOrder = Order.fromJson(mapOrder);

        Navigator.pushNamed(context, OrderDetail.routeName, arguments: {
          'order': newOrder,
          'idUser': idUser
        },); //newOrder
      }
    }else{
        // Modification de l'objet proposition à envoyer au back
        Proposition proposition = Proposition(
          announce: announce,
          userProposition: user,
          proposition: int.parse(priceController.text),
          statusProposition: statusPropositionProposition,
        );
        print(proposition);
        // On récupère le json renvoyé et on le convertit en objet order pour l'envoyer à la route.
        var response = await createProposition(proposition);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proposition envoyée !')),
          );
          Navigator.pushNamed(context, '/');
        }
      }
    }
}