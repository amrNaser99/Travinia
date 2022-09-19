import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/hex_color.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final text;
  final textColor;
  final textSize;
  final fillColor;
  final fontWeight;
  final bool withShadow;
  final buttonWidth;
  final borderRadius;
  final height;

  const CustomButton(
      {Key? key,
      required this.text,
      this.height,
      this.buttonWidth,
      this.textSize,
      this.fontWeight,
      this.withShadow = false,
      this.textColor,
      this.fillColor,
      this.borderRadius,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: withShadow ? AppConst.shadow : null),
      height: height ?? 53.0,
      width: buttonWidth ?? double.infinity,
      child: RawMaterialButton(
        animationDuration: Duration(seconds: 1),
        focusElevation: 0.0,
        hoverElevation: 0.0,
        elevation: 0.0,
        highlightElevation: 0.0,
        onPressed: onPressed,
        child: CustomText(
          text: text,
          size: textSize ?? AppConst.fontSizeM,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: textColor ?? Colors.white,
        ),
        fillColor: fillColor ?? HexColor('#4FBE9E'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppConst.radius,
          ),
        ),
      ),
    );
  }
}
