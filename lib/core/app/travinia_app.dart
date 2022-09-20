import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/core/utils/routes.dart';

class TraviniaApp extends StatelessWidget {
  const TraviniaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppCubit>(
                create: (context) => sl<AppCubit>(),
              ),
            ],
            child: BlocBuilder<AppCubit, AppStates>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Travinia',
                  debugShowCheckedModeBanner: false,
                  theme: AppThemes.darkTheme,
                  routes: Routes.routes,
                  initialRoute: Routes.onBoarding,
                );
              },
            ),
          );
        });
  }
}
