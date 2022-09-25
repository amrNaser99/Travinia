import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/test/widgets/body/hotel_image.dart';
import 'package:travinia/presentation/test/widgets/body/hotel_name_and_location.dart';
import 'package:travinia/presentation/test/widgets/body/hotel_price_per_night.dart';
import 'package:travinia/presentation/test/widgets/body/hotel_rating_and_distance.dart';

class HotelCardInfo extends StatelessWidget {
  final HotelModel hotel;
  const HotelCardInfo({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h130,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HotelImage(),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(AppSize.s8).add(EdgeInsets.only(
                  top: AppHeight.h4,
                  bottom: AppHeight.h4,
                  right: AppWidth.w2,
                )),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HotelNameLocation(
                            location: hotel.address,
                            name: hotel.name,
                          ),
                          Spacer(),
                          HotelDistanceAndRating(
                            distance: '1200',
                            rate: "5",
                          ),
                        ],
                      ),
                    ),
                    HotelPreicePerNight(price: hotel.price)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
