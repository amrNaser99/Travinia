import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';

import '../../../core/app/bloc/app_cubit.dart';
import 'app_bar/home_app_bar.dart';
import 'body/best_deals_head.dart';
import 'body/hotel_card_info.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        HomeAppBar(),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppWidth.w10),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppHeight.h20),
                  BestDealsHead(),
                  ListView.separated(
                    shrinkWrap: true,
                    physics:
                    NeverScrollableScrollPhysics(),
                    itemCount: cubit.hotels.length,
                    separatorBuilder: (context,
                        index) =>
                        SizedBox(height: AppHeight.h20),
                    itemBuilder: (context, index) =>
                        HotelCardInfo(
                            hotel: cubit.hotels[index]),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
