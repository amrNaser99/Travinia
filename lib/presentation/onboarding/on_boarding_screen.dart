import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_strings.dart';
import 'package:travinia/presentation/onboarding/page_view_content.dart';

import '../../core/utils/app_spaces.dart';
import '../shared_widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  allowImplicitScrolling: true,
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    PageViewContent(
                      imagePath: AppStrings.onBoardingImgPath1,
                      title: "Plan your trips",
                      subTitle:
                          "Book one of your unique hotel to escape the ordinary",
                    ),
                    PageViewContent(
                      imagePath: AppStrings.onBoardingImgPath2,
                      title: "Find best deals",
                      subTitle:
                          "Find deals for any season from cosy country homes to city flats",
                    ),
                    PageViewContent(
                      imagePath: AppStrings.onBoardingImgPath3,
                      title: "Best traveling all time",
                      subTitle:
                          "Find deals for any season from cosy country homes to city flats",
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                effect: WormEffect(
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  dotColor:
                      AppCubit.get(context).secondaryColor.withOpacity(0.2),
                  activeDotColor: AppColors.appColor,
                ),
                count: 3,
              ),
              AppSpaces.vSpace20,
              AppSpaces.vSpace20,
              Padding(
                padding: const EdgeInsets.only(
                    right: 50.0, bottom: 30.0, left: 50.0),
                child: Column(
                  children: [
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        AppCubit.get(context).changeAppThemeColor();
                      },
                    ),
                    AppSpaces.vSpace20,
                    CustomButton(
                      text: "Create account",
                      withShadow: true,
                      textColor: AppCubit.get(context).secondaryColor,
                      fillColor: AppColors.thirdColor.withOpacity(
                        AppCubit.get(context).colorOpacity,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
