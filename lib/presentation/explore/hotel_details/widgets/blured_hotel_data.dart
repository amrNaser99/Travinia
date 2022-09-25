import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_spaces.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../models/hotel_model.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/custom_text.dart';
import 'more_details_button.dart';

class BluredHotelDataContainer extends StatelessWidget {
  final ExploreCubit hotelDetailsCubit;
  final HotelModel hotelModel;
  const BluredHotelDataContainer(
      {Key? key, required this.hotelDetailsCubit, required this.hotelModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: hotelDetailsCubit.opacityValue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Blur(
                  borderRadius: BorderRadius.circular(25.0),
                  blurColor: Colors.transparent,
                  child: Container(
                    height: AppHeight.h160,
                  ),
                ),
                Container(
                  height: AppHeight.h160,
                  padding: EdgeInsetsDirectional.all(30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryWithStaticColorText(
                            text: hotelModel.name,
                            size: AppSize.s15,
                            fontWeight: FontWeight.bold,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryWithStaticColorText(
                                text: '\$180',
                                size: AppSize.s17,
                                fontWeight: FontWeight.bold,
                              ),
                              PrimaryWithStaticColorText(
                                text: 'per night',
                                size: AppSize.s11,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          PrimaryWithStaticColorText(
                            text: 'Wembley, London',
                            size: AppSize.s10,
                          ),
                          Icon(
                            Icons.location_on,
                            color: AppColors.appColor,
                          ),
                          PrimaryWithStaticColorText(
                            text: '2.0 Km to city',
                            size: AppSize.s10,
                          ),
                        ],
                      ),
                      AppSpaces.vSpace10,
                      Container(
                        child: CustomButton(text: 'Book now', onPressed: () {}),
                        height: AppHeight.h40,
                      )
                    ],
                  ),
                ),
              ],
            ),
            AppSpaces.vSpace10,
            MoreDetailsButton(hotelScreenCubit: hotelDetailsCubit),
          ],
        ),
      ),
    );
  }
}
