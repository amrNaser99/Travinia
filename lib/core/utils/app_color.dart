import 'package:flutter/material.dart';
import 'package:travinia/core/utils/hex_color.dart';

class AppColors {
  static Color primaryColor = Colors.white;
  //primaryColor Is the color that will be used as a background
  static Color secondaryColor = Colors.black;
  //secondaryColor Is the color that will be used in a widget like icons,texts,..etc
  static Color thirdColor = Colors.white;
  //thirdColor Is the color that will not changed it will still white but you must change it's opacity when toggling between light | dark themes
  //this will be used in some widgets background like containers, Buttons,..etc
  static final Color primaryDarkColor = Colors.black;
  static final Color secondaryDarkColor = Colors.white;
  static final HexColor appColor = HexColor('#4FBE9E');
}
