import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/bloc_observer.dart';
import 'package:travinia/core/app/travinia_app.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/presentation/explore/explore_hotel_screen.dart';
import 'package:travinia/presentation/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  init();

  runApp(const TraviniaApp());
  Bloc.observer = MyBlocObserver();
}


