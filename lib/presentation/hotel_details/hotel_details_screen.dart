import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/presentation/hotel_details/widgets/sliver_app_bar.dart';
import 'package:travinia/presentation/hotel_details/widgets/sliver_list_items.dart';
import '../../core/di/injection.dart';
import '../../models/hotel_model.dart';
import 'hotel_details_cubit/hotel_details_cubit.dart';
import 'hotel_details_cubit/hotel_details_states.dart';

class HotelDetailsScreen extends StatelessWidget {
  final HotelModel hotelModel;
  const HotelDetailsScreen({Key? key, required this.hotelModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HotelDetailsCubit>()..changeOpacityValue(),
      child: Scaffold(
        body: BlocBuilder<HotelDetailsCubit, HotelDetailsStates>(
          builder: (context, state) {
            HotelDetailsCubit hotelDetailsCubit =
                HotelDetailsCubit.get(context);
            return CustomScrollView(
              controller: hotelDetailsCubit.scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBarWidget(hotelDetailsCubit: hotelDetailsCubit),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SliverListItems(hotelModel: hotelModel),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
