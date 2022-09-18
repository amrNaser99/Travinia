import 'package:flutter/material.dart';

import '../../presentation/home/home_screen.dart';

class Routes {
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
    };
  }
}
