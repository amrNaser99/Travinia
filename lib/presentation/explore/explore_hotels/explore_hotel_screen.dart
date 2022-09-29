import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_app_bar_widget.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_hotel_appbar.dart';

class ExploreHotelScreen extends StatefulWidget {
  const ExploreHotelScreen({Key? key}) : super(key: key);

  @override
  State<ExploreHotelScreen> createState() => _ExploreHotelScreenState();
}

class _ExploreHotelScreenState extends State<ExploreHotelScreen> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).getHotels();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<HotelModel> hotelData = BlocProvider.of<AppCubit>(context).hotels;
        debugPrint('hotelData.length ${hotelData.length}');

        return Scaffold(
          body: ConditionalBuilder(
            condition: hotelData.isNotEmpty,
            builder: (BuildContext context) {
              return ExploreHotelAppBar(
                hotelData: hotelData,
              );
            },
            fallback: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
