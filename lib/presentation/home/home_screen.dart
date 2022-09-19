import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: ConditionalBuilder(
              condition: state is FacilitiesLoadingState,
              builder: (context) => Text("LOADING"),
              fallback: (context) => MaterialButton(
                onPressed: () {
                  AppCubit.get(context).getFacilities();
                },
                color: Colors.red,
                child: Text('GET FACILETIES'),
              ),
            ),
          ),
        );
      },
    );
  }
}
