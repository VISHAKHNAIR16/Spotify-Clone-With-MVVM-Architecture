import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
