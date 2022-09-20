import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_contstants.dart';
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
        AppSpaces.vSpace20,
        Image.asset(imagePath, height: 180.0),
        AppSpaces.expandedSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomText(
            text: title,
            size: AppConst.fontSizeL + 2,
            fontWeight: FontWeight.bold,
            maxLinesNumber: 2,
            textAlign: TextAlign.center,
            showEllipsis: true,
          ),
        ),
        AppSpaces.vSpace20,
        AppSpaces.vSpace10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomText(
            text: subTitle,
            size: AppConst.fontSizeM - 2,
            fontWeight: FontWeight.normal,
            withOpacity: 0.5,
            textAlign: TextAlign.center,
          ),
        ),
        AppSpaces.vSpace20,
        AppSpaces.vSpace20,
        AppSpaces.vSpace20,
      ],
    );
  }
}
