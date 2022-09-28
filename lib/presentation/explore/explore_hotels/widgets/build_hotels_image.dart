import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';

import '../../../home/body/hotel_card_info.dart';

class buildHotelsImage extends StatelessWidget {
  final List<HotelModel> hotelData;

  const buildHotelsImage({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

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
                      HotelCardInfo(hotel: hotelData[index]),
                  separatorBuilder: (context, index) => AppSpaces.vSpace10,
                  itemCount: hotelData.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
