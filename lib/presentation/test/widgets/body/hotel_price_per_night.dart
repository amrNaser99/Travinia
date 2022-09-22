import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class HotelPreicePerNight extends StatelessWidget {
  final String price;
  const HotelPreicePerNight({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: LargeHeadText(
            text: "\$${AppConst.handleLargeNumbers(price)}",
            size: FontSize.s20,
          ),
        ),
        SecondaryText(
          text: '/per night',
          size: FontSize.s11,
          isLight: true,
        )
      ],
    );
  }
}
