import 'package:weezli/views/announce/announce_detail.dart';
import 'package:weezli/widgets/avatar.dart';
import 'package:weezli/widgets/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardItem extends StatelessWidget {
  final searchValues;
  CardItem(this.searchValues);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AnnounceDetail.routeName),
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
