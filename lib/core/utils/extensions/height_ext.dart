import 'package:flutter/material.dart';

extension getDeviceHeight on BuildContext {
  double get height => MediaQuery.of(this).size.height;
}

extension getDeviceWidth on BuildContext {
  double get width => MediaQuery.of(this).size.width;
}
