import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
              ConditionalBuilder(
                condition: state is UserLoginLoadingState,
                builder: (context) => Text("LOADING"),
                fallback: (context) => MaterialButton(
                  onPressed: () {
                    AuthCubit.get(context).userLogin();
                  },
                  color: Colors.deepOrangeAccent,
                  child: Text('GET Booking'),
                ),
              ),
              ConditionalBuilder(
                condition: state is UserProfileLoadingState,
                builder: (context) => Text("LOADING"),
                fallback: (context) => MaterialButton(
                  onPressed: () {
                    AuthCubit.get(context).userProfile();
                  },
                  color: Colors.red,
                  child: Text('User Profile'),
                ),
              ),
              ConditionalBuilder(
                condition: state is HotelsLoadingState,
                builder: (context) => Text("LOADING"),
                fallback: (context) => MaterialButton(
                  onPressed: () {
                    AppCubit.get(context).getHotels();
                  },
                  color: Colors.red,
                  child: Text('GET Hotels'),
                ),
              ),
              ConditionalBuilder(
                condition: state is GetBookingLoadingState,
                builder: (context) => Text("LOADING"),
                fallback: (context) => MaterialButton(
                  onPressed: () {
                    AppCubit.get(context).getBooking(context: context);
                  },
                  color: Colors.deepPurple,
                  child: Text('GET Booking'),
                ),
              ),
              ConditionalBuilder(
                condition: state is UserRegisterLoadingState,
                builder: (context) => Text("LOADING"),
                fallback: (context) => MaterialButton(
                  onPressed: () {
                    AuthCubit.get(context).userRegister();
                  },
                  color: Colors.deepPurple,
                  child: Text('Register'),
                ),
              ),
              ConditionalBuilder(
                condition: state is UserLoginLoadingState,
                builder: (context) => Text("LOADING"),
                fallback: (context) => MaterialButton(
                  onPressed: () {
                    AuthCubit.get(context).userLogin();
                  },
                  color: Colors.orangeAccent,
                  child: Text('Login'),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
