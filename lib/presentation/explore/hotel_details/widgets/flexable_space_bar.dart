import 'package:flutter/material.dart';
import 'package:travinia/core/utils/extensions/height_ext.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/hotel_details/cubit/hotel_details_page_cubit.dart';
import 'package:travinia/presentation/explore/hotel_details/widgets/blured_hotel_data.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';

class FlexableSpaceBarWidget extends StatelessWidget {
  final HotelDetailsPageCubit hotelDetailsCubit;
  final HotelModel hotelModel;
  final hotelDetailsScreenContext;
  const FlexableSpaceBarWidget({
    Key? key,
    required this.hotelDetailsCubit,
    required this.hotelModel,
    required this.hotelDetailsScreenContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          height: context.height,
          width: context.width,
          AppStrings.hotelImgPath,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              left: AppHeight.h15,
              right: AppHeight.h15,
              bottom: AppHeight.h40,
            ),
            child: BluredHotelDataContainer(
              hotelDetailsCubit: hotelDetailsCubit,
              hotelDetailsScreenContext: hotelDetailsScreenContext,
              hotelModel: hotelModel,
            ),
          ),
        ),
      ],
    );
  }
}
