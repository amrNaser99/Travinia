import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/widgets/pop_up_menu.dart';

class BookingHotelImage extends StatelessWidget {
  final int bookingId;
  final int index;
  const BookingHotelImage(
      {super.key, required this.bookingId, required this.index});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.s16),
        topRight: Radius.circular(AppSize.s16),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Image.asset(
            'assets/images/hotel.jpg',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          BookingPopupMenu(
            bookingId: bookingId,
            index: index,
          )
        ],
      ),
    );
  }
}
