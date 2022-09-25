import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_values.dart';

class HomeAppBarPageIndicator extends StatelessWidget {
  final PageController pageController;
  const HomeAppBarPageIndicator({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w16)
          .add(EdgeInsets.only(bottom: AppHeight.h10)),
      child: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: SmoothPageIndicator(
          controller: pageController,
          effect: WormEffect(
            dotWidth: AppSize.s9,
            dotHeight: AppSize.s9,
            dotColor: AppColors.grey,
            activeDotColor: AppColors.appColor,
          ),
          count: 3,
        ),
      ),
    );
  }
}
