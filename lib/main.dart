import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travinia/core/app/travinia_app.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/presentation/main/dio_test.dart';
import 'package:travinia/services/geo_locator/geo_locator_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  DioTest.init();
  Position position = await GeoLocatorHelper.determinePosition();
  runApp(const TraviniaApp());
}
