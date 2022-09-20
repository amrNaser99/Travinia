import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: AppColors.generateMaterialColor(AppColors.teal),
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
    // COLORS
    primarySwatch: AppColors.generateMaterialColor(AppColors.teal),
    scaffoldBackgroundColor: AppColors.black,

    ///APP BAR
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      backgroundColor: AppColors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle:
          getSemiBoldStyle(fontColor: AppColors.white, fontSize: FontSize.s16),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),

    /// elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      elevation: 0,
      primary: AppColors.teal,
      textStyle: getMediumStyle(
        fontColor: AppColors.white,
        fontSize: FontSize.s15,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20)),
      minimumSize: Size(double.infinity, AppHeight.h45),
    )),

    ///card
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.lightGrey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16)),
    ),

    /// text
    textTheme: TextTheme(
      bodyLarge:
          getBoldStyle(fontColor: AppColors.white, fontSize: FontSize.s16),
      bodyMedium: getMediumStyle(fontColor: AppColors.grey),
    ),

    /// input decoration
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularStyle(
        fontColor: AppColors.secondGrey,
      ),
      fillColor: AppColors.lightGrey,
      filled: true,
      contentPadding: EdgeInsets.symmetric(
          vertical: AppHeight.h2, horizontal: AppWidth.w10),
      errorStyle: getRegularStyle(
        fontColor: AppColors.lightRed,
        fontSize: FontSize.s12,
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide(
            color: AppColors.secondGrey,
          )),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide: BorderSide(
          color: AppColors.secondGrey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide: BorderSide(
          color: AppColors.secondGrey,
        ),
      ),
    ),
  );
}
