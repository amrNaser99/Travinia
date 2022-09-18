import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/app/blocs/bloc_observer.dart';
import 'package:travinia/core/app/services/remote_service/dio_helper.dart';
import 'package:travinia/core/app/travinia_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();

  runApp(const TraviniaApp());
  Bloc.observer = MyBlocObserver();
}





