import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/widgets/hotel_location_and_distance.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_price_per_night.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_rating.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class BookingHotelDetails extends StatelessWidget {
  const BookingHotelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeHeadText(
                  text: "Queen Hotel",
                  size: FontSize.s18,
                ),
                SizedBox(height: AppHeight.h3),
                const HotleLocationAndDistance(),
                SizedBox(height: AppHeight.h3),
                HotelRating(rate: "4.5")
              ],
            ),
          ),
          HotelPreicePerNight(
            price: "20",
            isBooking: true,
          )
        ],
      ),
    );
  }
}
