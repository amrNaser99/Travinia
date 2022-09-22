import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/utils/extensions/height_ext.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_values.dart';
import '../../shared_widgets/custom_text.dart';
import '../hotel_details_cubit/hotel_details_cubit.dart';

class MoreDetailsButton extends StatelessWidget {
  final HotelDetailsCubit hotelScreenCubit;
  const MoreDetailsButton({Key? key, required this.hotelScreenCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hotelScreenCubit.scrollController.animateTo(
          context.height * 0.85,
          duration: Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryWithStaticColorText(
              text: 'More Details',
              fontWeight: FontWeight.bold,
              size: AppSize.s11,
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.white,
            )
          ],
        ),
      ).frosted(
        borderRadius: BorderRadius.circular(25.0),
        height: AppHeight.h30,
        width: AppWidth.w150,
        frostColor: Colors.transparent,
      ),
    );
  }
}
