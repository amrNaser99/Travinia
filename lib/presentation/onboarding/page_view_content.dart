import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

import '../../core/utils/app_spaces.dart';

class PageViewContent extends StatelessWidget {
  const PageViewContent({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppHeight.h20),
        Image.asset(imagePath, height: AppHeight.h180),
        AppSpaces.expandedSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
          child: LargeHeadText(
            text: title,
            size: AppSize.s18,
          ),
        ),
        SizedBox(height: AppHeight.h20),
        SizedBox(height: AppHeight.h10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
          child: SecondaryText(
            text: subTitle,
            center: true,
            // size: AppConst.fontSizeM - 2,
          ),
        ),
        SizedBox(height: AppHeight.h20),
        SizedBox(height: AppHeight.h20),
        SizedBox(height: AppHeight.h20),
      ],
    );
  }
}
