import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/widgets/booking_hotel_details.dart';
import 'package:travinia/presentation/booking/widgets/booking_hotel_image.dart';

class BookingCardInfo extends StatelessWidget {
  const BookingCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h250,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 5,
              child: BookingHotelImage(),
            ),
            SizedBox(height: AppHeight.h5),
            Expanded(
              flex: 2,
              child: BookingHotelDetails(),
            ),
          ],
        ),
      ),
    );
  }
}
