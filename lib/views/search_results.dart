import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

import 'announce/announce_detail.dart';

class SearchResults {

  bool sendBool = false;
  
  Widget allResults(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          OutlinedButton(
            onPressed: (){}, 
            child: Text("Déposer une annonce pour votre colis sur ce trajet.", textAlign: TextAlign.center,),
            style: OutlinedButton.styleFrom(
              primary: Colors.blue,
              side: BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              fixedSize: Size.fromWidth(300),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50)
            ),
          ),
          Divider(thickness: 2,),
          oneResult(context),
          oneResult(context),
          oneResult(context),
          oneResult(context),
          oneResult(context),
          oneResult(context),
          Divider(color: Colors.blue, thickness: 2,),
        ],
      ),
    );
  }

  Widget oneResult(BuildContext context) {
    return GestureDetector(
        onTap: (){
      Navigator.pushNamed(context, AnnounceDetail.routeName);
    },child : Container(
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
          SizedBox(width: 20,),
          packageInformations(),
          Spacer(),
          price(),
        ],
      ),
    ),
    );
  }

  Widget contact(){
    return Column(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30, //MediaQuery.of(context).size.width/15,
              foregroundImage: NetworkImage("https://images.assetsdelivery.com/compings_v2/macrovector/macrovector1901/macrovector190100030.jpg"),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 7,
              child: SvgPicture.asset("assets/images/svg/check.svg"),
            ),
          ],
        ),
        //SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.smartphone, size: 19,),
            SizedBox(width: 2),
            Icon(Icons.contact_phone_outlined, size: 19,),
            SizedBox(width: 2),
            Icon(Icons.mail_outline, size: 19,),
          ],
        )
      ],
    );
  }

  Widget packageInformations(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Melinda",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo[900]),
            ),
            SizedBox(width: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              child: Row(
                children: [
                  Icon(Icons.star, size: 12,),
                  Text(
                    "4",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),
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
              style: TextStyle(fontSize: 14, color: Colors.indigo[900], fontWeight: FontWeight.w500),
            ),
            Icon(Icons.arrow_right_alt),
            Text(
              "Madagascar",
              style: TextStyle(fontSize: 14, color: Colors.indigo[900], fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  Widget price(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sendBool ? sendIcon() : carryIcon(),
        Text.rich(
          TextSpan(
            text: "100",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo[900]),
            children: [
              TextSpan(
                text: "€",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo[900]),
              )
            ]
          )
        )
      ],
    );
  }

  Widget sendIcon(){
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: SvgPicture.asset(
        "assets/images/svg/send.svg", 
        color: Colors.white,
      ),
    );
  }
  Widget carryIcon(){
    return CircleAvatar(
      backgroundColor: Colors.amber,
      child: SvgPicture.asset("assets/images/svg/delivery.svg"),
    );
  }
}