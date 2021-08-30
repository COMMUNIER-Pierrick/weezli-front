import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Avatar extends StatelessWidget {
  final double radius;
  Avatar(this.radius);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: radius, //MediaQuery.of(context).size.width/15,
          foregroundImage: NetworkImage(
              "https://images.assetsdelivery.com/compings_v2/macrovector/macrovector1901/macrovector190100030.jpg"),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 10,
          child: SvgPicture.asset("assets/images/svg/check.svg"),
        ),
      ],
    );
  }
}
