import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';

class HomeImageSlider extends StatefulWidget {
  const HomeImageSlider({super.key});

  @override
  State<HomeImageSlider> createState() => _HomeImageSliderState();
}

class _HomeImageSliderState extends State<HomeImageSlider> {
  final List<OnBoardingModel> _onBoardingData = [
    const OnBoardingModel(
      title: "Cape Town",
      description: '''Extraordinary five-star 
outdoor activites.''',
      image: "assets/images/hotel.jpg",
    ),
    const OnBoardingModel(
      title: "Cairo",
      description: '''Discover the secrets of the pharos 
totaly new vibes.''',
      image: "assets/images/hotel.jpg",
    ),
    const OnBoardingModel(
      title: "New York",
      description: '''Extraordinary five-star 
outdoor activites.''',
      image: "assets/images/hotel.jpg",
    ),
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _goRight() {
    setState(() {
      if (_currentIndex != _onBoardingData.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 400),
          curve: Curves.bounceIn,
        );
      } else {
        _currentIndex = 0;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 100),
          curve: Curves.bounceIn,
        );
      }
    });
    print(_currentIndex);
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      _goRight();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        PageView.builder(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemCount: _onBoardingData.length,
          itemBuilder: (context, index) {
            return Image.asset(
              "assets/images/hotel.jpg",
              fit: BoxFit.fill,
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w16)
              .add(EdgeInsets.only(bottom: AppHeight.h10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _onBoardingData[_currentIndex].title,
                style: getBoldStyle(
                    fontColor: AppColors.white, fontSize: FontSize.s22),
              ),
              SizedBox(height: AppHeight.h5),
              Text(
                _onBoardingData[_currentIndex].description,
                style: getMediumStyle(
                    fontColor: AppColors.offWhite, fontSize: FontSize.s13),
              ),
              SizedBox(height: AppHeight.h10),
              SizedBox(
                width: AppWidth.w130,
                child: CustomButton(
                  text: "View Hotel",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w16)
              .add(EdgeInsets.only(bottom: AppHeight.h10)),
          child: Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: SmoothPageIndicator(
              controller: _pageController,
              effect: WormEffect(
                dotWidth: AppSize.s9,
                dotHeight: AppSize.s9,
                dotColor: AppColors.grey,
                activeDotColor: AppColors.appColor,
              ),
              count: 3,
            ),
          ),
        )
      ],
    );
  }
}

class OnBoardingModel {
  final String title;
  final String description;
  final String image;

  const OnBoardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}
