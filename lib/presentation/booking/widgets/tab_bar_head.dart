import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/presentation/booking/bloc/booking_cubit.dart';

class TabBarHead extends StatelessWidget {
  final TabController controller;
  const TabBarHead({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cubit = BookingCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s30),
        border: Border.all(color: Theme.of(context).hintColor),
        color: Theme.of(context).hintColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppHeight.h5, horizontal: AppWidth.w10),
        child: TabBar(
          controller: controller,
          labelColor: AppColors.teal,
          unselectedLabelColor: AppColors.grey,
          unselectedLabelStyle: getMediumStyle(
            fontColor: AppColors.grey,
            fontSize: AppSize.s14,
          ),
          indicatorColor: Colors.transparent,
          labelStyle: getBoldStyle(
            fontSize: AppSize.s15,
            fontColor: Theme.of(context).textTheme.bodyLarge!.color!,
          ),
          isScrollable: true,
          onTap: (index) {
            // cubit.changeTabBar(index);
            cubit.createBooking();
            debugPrint("a7a");
          },
          tabs: cubit.bookings
              .map((element) => Tab(
                    text: element.title,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
