import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/widgets/pop_up_menu.dart';

class BookingHotelImage extends StatelessWidget {
  const BookingHotelImage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = ["1", "2", "3"];
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
            fit: BoxFit.fill,
          ),
          BookingPopupMenu()
        ],
      ),
    );
  }
}
