import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/core/utils/routes.dart';

class TraviniaApp extends StatelessWidget {
  const TraviniaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => sl<AppCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Travinia',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        routes: Routes.routes,
        initialRoute: Routes.home,
      ),
    );
  }
}
