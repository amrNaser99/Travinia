import 'package:flutter/material.dart';
import 'package:travinia/core/app/travinia_app.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/presentation/main/dio_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  DioTest.init();
  runApp(const TraviniaApp());
}
