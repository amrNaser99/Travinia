import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/extensions/height_ext.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/shared_widgets/show_toast.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/app_spaces.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../models/hotel_model.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/custom_text.dart';

ConfirmBookingModalSheet({
  required BuildContext hotelDetailsScreenContext,
  required HotelModel hotelModel,
}) {
  return showModalBottomSheet(
    context: hotelDetailsScreenContext,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        height: context.height * 0.28,
        child: BlocProvider(
          create: (context) => sl<ExploreCubit>(),
          child: BlocConsumer<ExploreCubit, ExploreState>(
            listener: (context, state) {
              if (state is CreateBookingErrorState) {
                showToast(message: 'Your booking is not confirmed try again!');
              }
              if (state is BookingCreatedSuccessState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                showToast(
                  message: 'Your booking is confirmed successfully!',
                  backGroundColor: AppColors.black,
                  textColor: AppColors.appColor,
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeHeadText(text: 'Confirm Your Booking'),
                    AppSpaces.vSpace20,
                    Expanded(
                      child: TealText(
                        text:
                            "You're Going to Book a Room for ${hotelModel.name}",
                        isEllipsis: false,
                        size: AppSize.s13,
                      ),
                    ),
                    AppSpaces.vSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallHeadText(text: 'Payment'),
                        Row(
                          children: [
                            Text(
                              'Cash ',
                              style: TextStyle(
                                color: Colors.amberAccent,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.money_dollar_circle_fill,
                              color: Colors.amberAccent,
                            ),
                          ],
                        )
                      ],
                    ),
                    AppSpaces.vSpace10,
                    ConditionalBuilder(
                      condition: state is CreateBookingLoadingState,
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                      fallback: (context) => CustomButton(
                        text: 'Confirm Booking',
                        onPressed: () async {
                          ExploreCubit.get(context).createBooking(hotelModel);
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
