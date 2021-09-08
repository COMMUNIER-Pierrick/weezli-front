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

//Classe qui permet de faire un widget dynamique et appelle la classe qui fait le build

class AnnounceDetail extends StatefulWidget {
  static const routeName = '/announce-detail';

  @override
  _AnnounceDetail createState() => _AnnounceDetail();
}

class _AnnounceDetail extends State<AnnounceDetail> {
  String price = "100";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xE5E5E5),
              height: height * 0.9,
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Avatar(40),
                        SizedBox(width: 10),
                        Container(
                          // height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTitle("Melinda Rochel"),
                              Contact(),
                              SizedBox(height: 2),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(WeezlyIcon.delivery),
                                    SizedBox(width: 4),
                                    CustomTitle("Transporteur"),
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitle("Detail"),
                          Row(
                            children: [
                              Icon(WeezlyIcon.card_plane,
                                  color: WeezlyColors.blue3),
                              SizedBox(width: 20),
                              Text(
                                "France",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.arrow_right_alt),
                              Text(
                                "Madagascar",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(WeezlyIcon.calendar2,
                                  color: WeezlyColors.blue3),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildCustomText(
                                    context,
                                    "Date de départ : ",
                                    DateFormat.yMMMMd('fr')
                                        .add_Hm()
                                        .format(DateTime.now()),
                                  ),
                                  _buildCustomText(
                                    context,
                                    "Date d'arrivée : ",
                                    DateFormat.yMMMMd('fr')
                                        .format(DateTime.now()),
                                  ),
                                ],
                              )
                            ],
                          ),
                          _buildRow(
                              context, WeezlyIcon.box, "Dimension : ", "Petit"),
                          _buildRow(
                              context, WeezlyIcon.kg, "Poids : ", "0 - 500g"),
                          _buildRow(context, WeezlyIcon.ticket, "Commission : ",
                              "100 €"),
                          Container(
                            width: 225,
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupCounterOffer(context),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CONTRE-PROPOSITION",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: WeezlyColors.blue5,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      WeezlyIcon.arrow_right,
                                      size: 13,
                                    ),
                                  )
                                ],
                              ),
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.5),
                                ),
                                backgroundColor: WeezlyColors.grey3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 2),
                    CustomTitle("A propos"),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      textAlign: TextAlign.left,
                      style: TextStyle(height: 1.3),
                    )
                  ],
                ),
              ),
            ),
            Footer(
                height: height,
                childLeft: Text(
                  price + " €",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                childRight: "Contacter",
                saveForm: () {})
          ],
        ),
      ),
    );
  }

  RichText _buildCustomText(
      BuildContext context, String firstText, String secondText) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText2,
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
        SizedBox(width: 20),
        _buildCustomText(context, firstText, secondText)
      ],
    );
  }

  Widget _buildPopupCounterOffer(BuildContext context) {
    var myController = TextEditingController();
    return new Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomTitle("CONTRE PROPOSITION")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LimitedBox(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Combien proposez-vous pour transporter votre colis ?",
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    controller: myController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.euro),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  width: MediaQuery.of(context).size.width * 0.3,
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
                  width: MediaQuery.of(context).size.width * 0.3,
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
                    onPressed: () {
                      setState(() {
                        price = myController.text;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("VALIDER"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
