import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';

class TraviniaApp extends StatelessWidget {
  const TraviniaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => sl<AppCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Travinia',
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).currentAppTheme,
            routes: Routes.routes,
            initialRoute: Routes.onBoarding,
          );
        },
      ),
    );
  }
}
