import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
            onTap: (() {}),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(
                      1,
                      4.0,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 130,
                    width: 114,
                    child: Image.asset(
                      'assets/images/hotel.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotelName.toString(), //HOTEL NAME
                          style: TextStyle(
                              //fontFamily: ,
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          hotelAdress.toString(), // HOTEL ADRESS
                          style: TextStyle(
                            //fontFamily: ,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 28,
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
                                      size: 17,
                                    ),
                                    Text(
                                      ' 2.0 km to city', //ToDo: calculate HOTEL far distance
                                      style: TextStyle(
                                        //fontFamily: ,
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: RatingBar.builder(
                                    itemSize: 18,
                                    initialRating: double.parse(
                                        hotelRating), // HOTEL RATING
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.4),
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
                            SizedBox(
                              width: 34,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${hotelPrice.toString()}', //HOTEL PRICE PER NIGHT
                                  style: TextStyle(
                                      //fontFamily: ,
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '/per night',
                                  style: TextStyle(
                                    //fontFamily: ,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
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
