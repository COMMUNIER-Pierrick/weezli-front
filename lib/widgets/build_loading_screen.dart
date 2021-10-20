import 'package:flutter/material.dart';

buildLoadingScreen() {
  return Center(
    child: Container(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(),
    ),
  );
}
