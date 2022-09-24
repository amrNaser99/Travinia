import 'package:flutter/material.dart';
import 'package:travinia/core/utils/extensions/height_ext.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/hotel_details/widgets/blured_hotel_data.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../bloc/explore_cubit.dart';

class FlexableSpaceBarWidget extends StatelessWidget {
  final ExploreCubit hotelDetailsCubit;
  const FlexableSpaceBarWidget({Key? key, required this.hotelDetailsCubit})
      : super(key: key);

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
              hotelModel: HotelModel(
                id: 1,
                name: 'Grand Royal Hotel',
                rate: "4.5",
                address: "ASSA",
                hotel_images: [],
                updated_at: "",
                created_at: "",
                latitude: "1",
                longitude: "5",
                price: "544",
                description: 'ABSC',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
