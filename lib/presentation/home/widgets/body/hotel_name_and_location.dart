import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class HotelNameLocation extends StatelessWidget {
  final String name;
  final String location;
  const HotelNameLocation(
      {super.key, required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LargeHeadText(
          text: name,
          size: FontSize.s15,
        ),
        SecondaryText(
          text: location,
          size: FontSize.s12,
          isLight: true,
        ),
      ],
    );
  }
}
