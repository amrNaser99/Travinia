import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';

class HotelImage extends StatelessWidget {
  const HotelImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: AppHeight.h130,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s16),
            bottomLeft: Radius.circular(AppSize.s16),
          ),
          child: Image.asset(
            'assets/images/hotel.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
