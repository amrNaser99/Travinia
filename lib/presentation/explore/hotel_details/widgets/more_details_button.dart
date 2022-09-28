import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/extensions/height_ext.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

import '../../../../core/utils/app_color.dart';

class MoreDetailsButton extends StatelessWidget {
  final ExploreCubit hotelScreenCubit;
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
