import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required String fontFamily,
  required FontWeight fontWeight,
  required Color fontColor,
}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: fontColor);
}

///Bold font style
TextStyle getBoldStyle({double? fontSize, required Color fontColor}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.bold,
      fontColor: fontColor);
}

///SemiBold font style
TextStyle getSemiBoldStyle({double? fontSize, required Color fontColor}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.semiBold,
      fontColor: fontColor);
}

///Medium font style
TextStyle getMediumStyle({double? fontSize, required Color fontColor}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.medium,
      fontColor: fontColor);
}

///Regular font style
TextStyle getRegularStyle({double? fontSize, required Color fontColor}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.regular,
      fontColor: fontColor);
}

///Light font style
TextStyle getLightStyle({double? fontSize, required Color fontColor}) {
  double size = fontSize ?? FontSize.s14;
  return _getTextStyle(
      fontSize: size,
      fontFamily: FontFamily.fontFamily,
      fontWeight: FontWeightManager.light,
      fontColor: fontColor);
}
