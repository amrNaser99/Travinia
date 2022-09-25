import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_strings.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/presentation/onboarding/page_view_content.dart';

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
                  dotWidth: AppSize.s9,
                  dotHeight: AppSize.s9,
                  dotColor: Theme.of(context).canvasColor,
                  activeDotColor: AppColors.appColor,
                ),
                count: 3,
              ),
              SizedBox(height: AppHeight.h40),
              Padding(
                padding: EdgeInsets.only(
                    right: AppWidth.w50,
                    bottom: AppHeight.h30,
                    left: AppWidth.w50),
                child: Column(
                  children: [
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                    ),
                    SizedBox(height: AppHeight.h20),
                    CustomButton(
                      text: "Create account",
                      setShadow: true,
                      fillColor: Theme.of(context).hintColor,
                      textColor: Theme.of(context).focusColor,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.register);
                      },
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
