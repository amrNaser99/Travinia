import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class HotleLocationAndDistance extends StatelessWidget {
  const HotleLocationAndDistance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SecondaryText(
          text: "Wembly, London",
          size: FontSize.s13,
          isLight: true,
        ),
        SizedBox(width: AppWidth.w2),
        Icon(
          Icons.location_on_sharp,
          color: AppColors.appColor,
          size: AppSize.s15,
        ),
        SizedBox(width: AppWidth.w1),
        Flexible(
          child: SecondaryText(
            text: "12.0 Km from the city",
            size: FontSize.s13,
            isLight: true,
          ),
        ),
      ],
    );
  }
}
