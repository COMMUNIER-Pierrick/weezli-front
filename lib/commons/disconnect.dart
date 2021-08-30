import 'package:flutter/material.dart';

GestureDetector disconnect = GestureDetector(
  onTap: () {},
  child: Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(right: 20),
    child: Text(
      "Déconnexion",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
