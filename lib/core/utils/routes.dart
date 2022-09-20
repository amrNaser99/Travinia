import 'package:flutter/material.dart';

import '../../presentation/home/home_screen.dart';
import '../../presentation/onboarding/on_boarding_screen.dart';

class Routes {
  static const String home = '/home';
  static const String onBoarding = '/onBoarding';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      onBoarding: (context) => OnBoardingScreen(),
    };
  }
}
