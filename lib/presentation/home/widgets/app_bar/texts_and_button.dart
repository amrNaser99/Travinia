import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';

import '../../../../core/utils/routes.dart';
import '../../../../services/geo_locator/geo_locator_helper.dart';

import '../../../../core/utils/routes.dart';

class HomeAppBarTextsAndButton extends StatelessWidget {
  final String title;
  final String description;

  const HomeAppBarTextsAndButton(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w16)
          .add(EdgeInsets.only(bottom: AppHeight.h10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getBoldStyle(
                fontColor: AppColors.white, fontSize: FontSize.s22),
          ),
          SizedBox(height: AppHeight.h5),
          Text(
            description,
            style: getMediumStyle(
                fontColor: AppColors.offWhite, fontSize: FontSize.s13),
          ),
          SizedBox(height: AppHeight.h10),
          SizedBox(
            width: AppWidth.w130,
            child: CustomButton(
              text: "View Hotel",
              onPressed: () async {
                Navigator.pushNamed(context, Routes.exploreHotels);
                // await Permission.location.request();
                if (await Permission.location.isGranted) {
                  GeoLocatorHelper.determinePosition();
                } else {
                  Permission.location.request();
                }
                Navigator.pushNamed(context, Routes.exploreHotels);
              },
            ),
          ),
        ],
      ),
    );
  }
}
