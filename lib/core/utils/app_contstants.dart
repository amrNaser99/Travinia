import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;

class AppConst {
  static const String appName = 'Travinia';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Travinia is a travel app';
  // static const String appIcon = 'assets/images/app_icon.png';
  // static const String appLogo = 'assets/images/app_logo.png';
  static double fontSizeM = 13.0;
  static double fontSizeL = 16.0;
  static double radius = 50.0;
  static double mainPadding = 20.0;
  //Shadows
  static dynamic shadow = [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 20.0,
    )
  ];

  static String handleLargeNumbers(String text, {bool? isMeter}) {
    double num = double.parse(text);
    String result = num.toString();
    if (num >= 1000) {
      if (isMeter == true) {
        result = "${(num / 1000).round()}K";
      } else {
        result = "${(num / 1000)}K";
      }
    } else
      result = num.round().toString();
    return result;
  }

  static String calculateDistance({
    required lat1,
    required lon1,
    required lat2,
    required lon2,
  }) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    double result = 12742 * asin(sqrt(a));
    return handleLargeNumbers(result.toString());
  }
}
