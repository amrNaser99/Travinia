import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/presentation/home/widegts/hotels_list_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();

    AppCubit.get(context).getHotels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        if (state is HotelsLoadingState) {
          return Scaffold(
              backgroundColor: Colors.lightBlueAccent,
              body: Center(child: CircularProgressIndicator()));
        } else {}
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ConditionalBuilder(
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
                HotelslistWidegt(),
              ],
            ),
          ),
        );
      },
    );
  }
}
