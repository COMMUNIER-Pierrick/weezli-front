import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.smartphone,
          size: 19,
        ),
        SizedBox(width: 2),
        Icon(
          Icons.contact_phone_outlined,
          size: 19,
        ),
        SizedBox(width: 2),
        Icon(
          Icons.mail_outline,
          size: 19,
        ),
      ],
    );
  }
}
