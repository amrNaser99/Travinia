import 'package:flutter/material.dart';
import 'package:travinia/presentation/auth/login/login_screen.dart';
import 'package:travinia/presentation/auth/register/register_screen.dart';

import '../../presentation/home/home_screen.dart';
import '../../presentation/onboarding/on_boarding_screen.dart';

class Routes {
  static const String home = '/home';
  static const String onBoarding = '/onBoarding';
  static const String register = '/register';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      onBoarding: (context) => OnBoardingScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
    };
  }
}
