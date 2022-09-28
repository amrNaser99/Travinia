import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/bloc/booking_cubit.dart';
import 'package:travinia/presentation/booking/bloc/booking_states.dart';
import 'package:travinia/presentation/booking/widgets/booking_card_info.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class BookingsList extends StatelessWidget {
  final TabController controller;
  final BookingState state;
  const BookingsList(
      {super.key, required this.controller, required this.state});

  @override
  Widget build(BuildContext context) {
    final BookingCubit cubit = BookingCubit.get(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppHeight.h10, horizontal: AppWidth.w10),
        child: TabBarView(
            controller: controller,
            children: cubit.bookings.map((element) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                // element.bookingList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: AppHeight.h10),
                itemBuilder: (BuildContext context, int index) {
                  return BookingCardInfo(
                    // bookingId: element.bookingList[index].id!,
                    bookingId: index,
                    index: index,
                    state: state,
                  );
                },
              );
            }).toList()),
      ),
    );
  }
}
