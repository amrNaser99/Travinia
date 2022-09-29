import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/routes.dart';

import '../../core/app/bloc/app_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, Routes.onBoarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    'assets/images/app_icon.png',
                  ),
                ),
              ),
              Spacer(),
              PositionedDirectional(
                  bottom: AppHeight.h50, child: CircularProgressIndicator(color: Colors.black,)),
            ],
          ),
        );
      },
    );
  }
}
