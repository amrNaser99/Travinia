import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/hotel_model.dart';

import '../../../../core/utils/app_spaces.dart';
import '../../../../core/utils/app_values.dart';
import '../../../home/body/hotel_card_info.dart';
import '../../bloc/explore_cubit.dart';
import '../../bloc/explore_state.dart';

class buildSearchList extends StatelessWidget {
  final List<HotelModel> hotelResults;

  const buildSearchList({super.key, required this.hotelResults});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s10,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      HotelCardInfo(hotel: hotelResults[index]),
                  separatorBuilder: (context, index) => AppSpaces.vSpace10,
                  itemCount: hotelResults.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
