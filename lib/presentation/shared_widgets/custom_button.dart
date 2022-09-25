import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final String text;
  Color? fillColor;
  Color? textColor;
  bool setShadow;
  IconData? icon;

  CustomButton(
      {Key? key,
      required this.text,
      this.fillColor,
      this.textColor,
      this.setShadow = false,
      this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: setShadow ? AppConst.shadow : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Row(
                children: [
                  FaIcon(
                    icon,
                    color: Colors.white,
                  ),
                  SizedBox(width: AppWidth.w6),
                ],
              ),
            Text(
              text,
              style: getMediumStyle(
                fontColor: textColor ?? AppColors.white,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(primary: fillColor),
      ),
    );
  }
}
