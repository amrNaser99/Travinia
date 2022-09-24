// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/explore_on_map/explore_map_screen.dart';
import 'package:travinia/presentation/explore_on_map/widgets/google_map_widget.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';
import 'package:travinia/services/api_service/end_points.dart';

class HotelDataWidget extends StatelessWidget {
  const HotelDataWidget(
      {super.key,
      required this.hotelName,
      required this.hotelAdress,
      required this.distance,
      required this.hotelRating,
      required this.hotelPrice});

  final String hotelName;
  final String hotelAdress;
  final double distance;
  final String hotelRating;
  final String hotelPrice;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (BuildContext context, child) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExploreOnMap()));
            }),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color(0xff2C2C2C),
                // color: Color.fromARGB(255, 255, 255, 255),
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(AppSize.s18),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardTheme.shadowColor ??
                        AppColors.secondGrey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius:
                        Theme.of(context).cardTheme.color == null ? 16 : 0,
                    offset: Offset(
                      Theme.of(context).cardTheme.shadowColor == null ? 1 : 0,
                      Theme.of(context).cardTheme.shadowColor == null ? 4 : 0,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: AppHeight.h120,
                    width: AppWidth.w114,
                    child: Image.asset(
                      'assets/images/hotel.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        AppWidth.w8, AppWidth.w1, AppWidth.w12, AppWidth.w1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LargeHeadText(
                          text: hotelName.toString(),
                          size: FontSize.s15,
                        ),
                        SecondaryText(
                          text: hotelAdress.toString(),
                          size: FontSize.s12,
                        ),
                        SizedBox(
                          height: AppHeight.h30,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_sharp,
                                      color: AppColors.appColor,
                                      size: AppSize.s17,
                                    ),
                                    SecondaryText(
                                      text: ' $distance km to city',
                                      size: FontSize.s12,
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: AppWidth.w3),
                                  child: RatingBar.builder(
                                    itemSize: AppSize.s16,
                                    initialRating: double.parse(
                                        hotelRating), // HOTEL RATING
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(
                                        horizontal: AppWidth.w1),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: AppColors.appColor,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   width: AppWidth.w20,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(bottom: AppWidth.w8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  LargeHeadText(
                                    text: '\$${hotelPrice.toString()}',
                                    size: FontSize.s20,
                                  ),
                                  SecondaryText(
                                    text: '/per night',
                                    size: FontSize.s11,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
