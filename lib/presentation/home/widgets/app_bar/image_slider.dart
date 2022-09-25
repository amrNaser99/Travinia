import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travinia/presentation/home/widgets/app_bar/page_indicator.dart';
import 'package:travinia/presentation/home/widgets/app_bar/texts_and_button.dart';

class HomeImageSlider extends StatefulWidget {
  final bool textAndButtonVisibilty;
  const HomeImageSlider({super.key, required this.textAndButtonVisibilty});

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
    // print(_currentIndex);
  }

  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _goRight();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
        if (widget.textAndButtonVisibilty)
          HomeAppBarTextsAndButton(
            title: _onBoardingData[_currentIndex].title,
            description: _onBoardingData[_currentIndex].description,
          ),
        HomeAppBarPageIndicator(pageController: _pageController)
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
