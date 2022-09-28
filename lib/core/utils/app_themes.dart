import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    /// colors
    primarySwatch: AppColors.generateMaterialColor(AppColors.teal),
    scaffoldBackgroundColor: AppColors.offWhite,
    hintColor: AppColors.white,
    focusColor: AppColors.black,
    canvasColor: AppColors.grey.withOpacity(0.3),
    highlightColor: AppColors.grey.withOpacity(0.5),

    //Divider Color
    dividerColor: AppColors.grey.withOpacity(0.3),

    /// app bar
    appBarTheme: AppBarTheme(
      color: AppColors.offWhite,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle:
          getBoldStyle(fontColor: AppColors.white, fontSize: FontSize.s16),
    ),

    /// elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      elevation: 0,
      // foregroundColor: AppColors.teal,
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
      color: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16)),
    ),

    /// text
    textTheme: TextTheme(
      // big titles
      bodyLarge:
          getBoldStyle(fontColor: AppColors.black, fontSize: FontSize.s16),
      // small titles
      bodyMedium: getSemiBoldStyle(fontColor: AppColors.black),
      // body content grey
      bodySmall: getMediumStyle(fontColor: AppColors.grey),
      // body content primary
      displaySmall: getRegularStyle(fontColor: AppColors.black),
    ),

    /// input decoration
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularStyle(
        fontColor: AppColors.secondGrey.withOpacity(0.7),
      ),
      fillColor: AppColors.white,
      filled: true,
      contentPadding: EdgeInsets.symmetric(
          vertical: AppHeight.h2, horizontal: AppWidth.w12),
      errorStyle: getRegularStyle(
          fontColor: AppColors.lightRed, fontSize: FontSize.s12),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.white,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.white,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.white,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.white,
          )),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    // COLORS

    primarySwatch: AppColors.generateMaterialColor(AppColors.teal),
    scaffoldBackgroundColor: AppColors.black,
    hintColor: AppColors.lightGrey,
    focusColor: AppColors.white,
    canvasColor: AppColors.grey,
    highlightColor: AppColors.grey.withOpacity(0.5),

    //Divider Color
    dividerColor: AppColors.grey,

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
        statusBarColor: Colors.transparent,
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
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16)),
    ),

    /// text
    textTheme: TextTheme(
      // big titles
      bodyLarge:
          getBoldStyle(fontColor: AppColors.white, fontSize: FontSize.s16),
      // small titles
      bodyMedium: getSemiBoldStyle(fontColor: AppColors.white),
      // body content grey
      bodySmall: getMediumStyle(fontColor: AppColors.grey),
      // body content primary
      displaySmall: getRegularStyle(fontColor: AppColors.white),
    ),

    /// input decoration
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularStyle(
        fontColor: AppColors.secondGrey.withOpacity(0.7),
      ),
      fillColor: AppColors.lightGrey,
      filled: true,
      contentPadding: EdgeInsets.symmetric(
          vertical: AppHeight.h2, horizontal: AppWidth.w12),
      errorStyle: getRegularStyle(
          fontColor: AppColors.lightRed, fontSize: FontSize.s12),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
          )),
    ),
  );
}
