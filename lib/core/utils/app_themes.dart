import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travinia/core/utils/app_color.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'GermaniaOne',
      ),
      centerTitle: false,
      systemOverlayStyle: Platform.isIOS
          ? null
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: AppColors.primaryDarkColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: false,
      systemOverlayStyle: Platform.isIOS
          ? null
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
    ),
  );
}
