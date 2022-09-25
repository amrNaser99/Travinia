import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/presentation/test/widgets/bottom_nav_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
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
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: state is HotelsLoadingState
              ? Center(child: CircularProgressIndicator())
              : state is ErrorState
                  ? Center(child: Text("ERROR"))
                  : state is HotelsLoadingState
                      ? CircularProgressIndicator()
                      : state is ErrorState
                          ? Text("ERROR")
                          : cubit.homeNavWidget(),
          bottomNavigationBar: AppBottomNavigationBar(),
        );
      },
    );
  }
}
