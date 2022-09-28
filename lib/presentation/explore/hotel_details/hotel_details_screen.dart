import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/hotel_details/widgets/sliver_app_bar.dart';
import 'package:travinia/presentation/explore/hotel_details/widgets/sliver_list_items.dart';

class HotelDetailsScreen extends StatefulWidget {
  const HotelDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  initState() {
    super.initState();
    BlocProvider.of<ExploreCubit>(context).changeOpacityValue();
  }

  @override
  Widget build(BuildContext hotelDetailsScreenContext) {
    final hotelModel = ModalRoute.of(context)!.settings.arguments as HotelModel;
    return Scaffold(
      body: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          ExploreCubit hotelDetailsCubit = ExploreCubit.get(context);

          return CustomScrollView(
            controller: hotelDetailsCubit.scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBarWidget(
                hotelDetailsCubit: hotelDetailsCubit,
                hotelModel: hotelModel,
                hotelDetailsScreenContext: hotelDetailsScreenContext,
              ),
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
    );
  }
}
