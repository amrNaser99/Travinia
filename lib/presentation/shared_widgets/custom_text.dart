import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travinia/core/utils/app_contstants.dart';

class CustomText extends StatelessWidget {
  final text;
  final size;
  final color;
  final textAlign;
  final fontWeight;
  int? maxLinesNumber;
  bool showEllipsis;

  CustomText(
      {Key? key,
      this.maxLinesNumber,
      required this.text,
      this.size,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.showEllipsis = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLinesNumber,
      overflow: showEllipsis ? TextOverflow.ellipsis : null,
      style: GoogleFonts.andika(
        fontSize: size ?? AppConst.fontSizeM,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
      ),
    );
  }
}
