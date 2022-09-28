import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travinia/core/app/bloc/bloc_observer.dart';
import 'package:travinia/core/app/travinia_app.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/presentation/main/dio_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  DioTest.init();
  Bloc.observer = MyBlocObserver();

  runApp(const TraviniaApp());
}
