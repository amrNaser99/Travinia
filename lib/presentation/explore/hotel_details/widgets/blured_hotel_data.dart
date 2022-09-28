import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travinia/presentation/explore/hotel_details/cubit/hotel_details_page_cubit.dart';
import 'package:travinia/presentation/explore/hotel_details/widgets/confirm_booking_modal_sheet.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_spaces.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../models/hotel_model.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/custom_text.dart';
import 'more_details_button.dart';

class BluredHotelDataContainer extends StatelessWidget {
  final HotelDetailsPageCubit hotelDetailsCubit;
  final HotelModel hotelModel;
  final BuildContext hotelDetailsScreenContext;
  const BluredHotelDataContainer({
    Key? key,
    required this.hotelDetailsCubit,
    required this.hotelModel,
    required this.hotelDetailsScreenContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: hotelDetailsCubit.opacityValue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Blur(
                  borderRadius: BorderRadius.circular(25.0),
                  blurColor: Colors.transparent,
                  child: Container(
                    height: AppHeight.h190,
                  ),
                ),
                Container(
                  height: AppHeight.h190,
                  padding: EdgeInsetsDirectional.all(25.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: PrimaryWithStaticColorText(
                              text: hotelModel.name,
                              size: AppSize.s15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryWithStaticColorText(
                                text: '\$${hotelModel.price}',
                                size: AppSize.s17,
                                fontWeight: FontWeight.bold,
                              ),
                              PrimaryWithStaticColorText(
                                text: 'per night',
                                size: AppSize.s12,
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: PrimaryWithStaticColorText(
                                text: '${hotelModel.address}',
                                size: AppSize.s12,
                              ),
                            ),
                            Icon(
                              Icons.location_on,
                              color: AppColors.appColor,
                            ),
                            PrimaryWithStaticColorText(
                              text: '2.0 Km to city',
                              size: AppSize.s12,
                            ),
                          ],
                        ),
                      ),
                      Rating(rate: hotelModel.rate),
                      AppSpaces.vSpace10,
                      Container(
                        child: CustomButton(
                            text: 'Book now',
                            onPressed: () {
                              ConfirmBookingModalSheet(
                                hotelDetailsScreenContext:
                                    hotelDetailsScreenContext,
                                hotelModel: hotelModel,
                              );
                            }),
                        height: AppHeight.h40,
                      )
                    ],
                  ),
                ),
              ],
            ),
            AppSpaces.vSpace10,
            MoreDetailsButton(hotelScreenCubit: hotelDetailsCubit),
          ],
        ),
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final String rate;
  const Rating({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          itemSize: AppSize.s16,
          initialRating: double.parse(rate), // HOTEL RATING
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: Theme.of(context).highlightColor,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: AppColors.appColor,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        AppSpaces.hSpace10,
        PrimaryWithStaticColorText(
          text: '80 Reviews',
          size: AppSize.s11,
        )
      ],
    );
  }
}
