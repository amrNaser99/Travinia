import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travinia/core/utils/hex_color.dart';

class AppColors {
  static Color primaryColor = Colors.white;
  //#fff7f7f7
  //primaryColor Is the color that will be used as a background
  static Color secondaryColor = Colors.black;
  //secondaryColor Is the color that will be used in a widget like icons,texts,..etc
  static Color thirdColor = Colors.white;
  //thirdColor Is the color that will not changed it will still white but you must change it's opacity when toggling between light | dark themes
  //this will be used in some widgets background like containers, Buttons,..etc
  static final Color primaryDarkColor = Colors.black;
  static final Color secondaryDarkColor = Colors.white;
  static final HexColor appColor = HexColor('#4FBE9E');

  ////////////////////////////////////////////////////
  static const Color white = Colors.white;
  static Color lightRed = Colors.red.withOpacity(0.6);
  static final HexColor black = HexColor('#1A1A1A'); // dark background
  static final HexColor grey = HexColor('#6D6D6D'); // caption
  static final HexColor secondGrey = HexColor('#7D7D7D'); // textfield hint
  static final HexColor lightGrey =
      HexColor('#2C2C2C'); // button grey , textfield background
  static final HexColor darkGrey = HexColor('#555555'); // profile icons
  static final Color darkBlue = Colors.indigo;
  static final HexColor teal = HexColor('#4FBE9E'); // primary

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
