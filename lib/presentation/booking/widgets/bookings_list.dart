import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/bloc/booking_cubit.dart';
import 'package:travinia/presentation/booking/widgets/booking_card_info.dart';

class BookingsList extends StatelessWidget {
  final TabController controller;
  const BookingsList({super.key, required this.controller});

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
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: AppHeight.h10),
                itemBuilder: (BuildContext context, int index) =>
                    BookingCardInfo(),
              );
            }).toList()),
      ),
    );
  }
}
