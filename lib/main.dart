import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/app/bloc/bloc_observer.dart';
import 'package:travinia/core/app/travinia_app.dart';
import 'package:travinia/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  init();

  runApp(const TraviniaApp());
  Bloc.observer = MyBlocObserver();
}
