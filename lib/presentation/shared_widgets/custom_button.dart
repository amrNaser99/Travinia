import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/font_styles.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final String text;
  final Color? fillColor;

   CustomButton(
      {Key? key, required this.text, this.fillColor, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: getMediumStyle(fontColor: AppColors.white),
      ),
      style: ElevatedButton.styleFrom(primary: fillColor),
    );
  }
}
