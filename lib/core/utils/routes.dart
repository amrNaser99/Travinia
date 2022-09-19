import 'package:flutter/material.dart';
import 'package:travinia/presentation/auth/login/login_screen.dart';
import 'package:travinia/presentation/auth/register/register_screen.dart';

import '../../presentation/home/home_screen.dart';

class Routes {
  static const String home = '/home';
  static const String register = '/Register';
  static const String login = '/Login';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      register: (context) => const RegisterScreen(),
      login: (context) => const LoginScreen(),
    };
  }
}
