import 'package:baloogo/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../commons/weezly_colors.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/avatar.dart';
import '../../commons/weezly_icon_icons.dart';
import '../../widgets/contact.dart';

class AnnounceDetail extends StatelessWidget {
  static const routeName = '/announce-detail';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar();
    final height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    return Scaffold(
      appBar: appBar,
      body: Column(
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
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  CustomTitle("A propos"),
                  Text(
                    "asdassssssssssss a   a sd asd as s a as asd assd asdasd asd asd af f  d sd f sd fs d fsd f sdf sdf sd fsd f sdf sd f sd f sd fsd f sd fs df sd fsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd sd sfd sd dddddddddddddd sdf f fds sdfs dfdfs sdf sdf f s fd fs sf",
                    textAlign: TextAlign.left,
                    style: TextStyle(height: 1.3),
                  )
                ],
              ),
            ),
          ),
          Footer(
              height: height,
              childLeft: Text("100 €"),
              childRight: "Contacter",
              saveForm: () {})
        ],
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
}
