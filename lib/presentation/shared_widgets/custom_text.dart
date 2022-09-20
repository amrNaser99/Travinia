import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_contstants.dart';

class CustomText extends StatelessWidget {
  final text;
  final size;
  final color;
  final textAlign;
  final fontWeight;
  final withOpacity;
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
      this.withOpacity = 1.0,
      this.showEllipsis = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Text(
          text,
          textAlign: textAlign,
          maxLines: maxLinesNumber,
          overflow: showEllipsis ? TextOverflow.ellipsis : null,
          style: GoogleFonts.workSans(
            fontSize: size ?? AppConst.fontSizeM,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ??
                AppCubit.get(context).secondaryColor.withOpacity(withOpacity),
          ),
        );
      },
    );
  }
}
