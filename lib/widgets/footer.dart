import 'package:baloogo/commons/weezly_colors.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final num height;
  final Widget childLeft;
  final String childRight;
  final VoidCallback saveForm;


  Footer(
      {required this.height,
      required this.childLeft,
      required this.childRight,
      required this.saveForm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: WeezlyColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.26),
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(0, 1), // changes position of shadow
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          childLeft,
          ElevatedButton(
            onPressed: saveForm,
            child: Text(
              childRight.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50),
              primary: Theme.of(context).buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );
  }
}
