import 'package:flutter/material.dart';

class SizeRadioModel {
  bool isSelected;
  final String text;
  final IconData? icon;
  final double sizeIcon;

  SizeRadioModel({
    this.isSelected = false,
    required this.text,
    this.icon,
    this.sizeIcon = 30,
  });
}
