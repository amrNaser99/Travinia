import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class HotelPreicePerNight extends StatelessWidget {
  final String price;
  final bool isBooking;
  const HotelPreicePerNight(
      {super.key, required this.price, this.isBooking = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isBooking ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Flexible(
          child: LargeHeadText(
            text: "\$${AppConst.handleLargeNumbers(price)}",
            size: FontSize.s20,
          ),
        ),
        SecondaryText(
          text: '/per night',
          size: isBooking ? FontSize.s13 : FontSize.s11,
          isLight: true,
        )
      ],
    );
  }
}
