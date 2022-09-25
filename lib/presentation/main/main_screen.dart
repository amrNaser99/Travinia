import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/presentation/main/widgets/bottom_nav_bar.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    AppCubit.get(context).getHotels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: cubit.mainScreens[cubit.currentIndex],
          bottomNavigationBar: AppBottomNavigationBar(),
        );
      },
    );
  }
}
