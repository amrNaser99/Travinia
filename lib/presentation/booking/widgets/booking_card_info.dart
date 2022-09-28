import 'package:flutter/material.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/bloc/booking_cubit.dart';
import 'package:travinia/presentation/booking/bloc/booking_states.dart';
import 'package:travinia/presentation/booking/widgets/booking_hotel_details.dart';
import 'package:travinia/presentation/booking/widgets/booking_hotel_image.dart';

class BookingCardInfo extends StatelessWidget {
  final int bookingId;
  final int index;
  final BookingState state;
  const BookingCardInfo(
      {super.key,
      required this.bookingId,
      required this.index,
      required this.state});

  @override
  Widget build(BuildContext context) {
    final BookingCubit cubit = BookingCubit.get(context);
    return SizedBox(
      height: AppHeight.h250,
      child: Card(
        child: state is UpdateBookingsLoading &&
                cubit.bookings[cubit.tabBarIndex].loadingList.contains(index)
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 5,
                    child: BookingHotelImage(
                      bookingId: bookingId,
                      index: index,
                    ),
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
