import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travinia/services/api_service/end_points.dart';

class HotelslistWidegt extends StatelessWidget {
  const HotelslistWidegt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      List hotelslistWidegt = AppCubit.get(context).hotels;
      return Expanded(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            // var imageName = '35321662903840.jpg';
            // if (hotelslistWidegt[index].hotel_images != null &&
            //     hotelslistWidegt[index].hotel_images.length != 0) {
            //   imageName = hotelslistWidegt[index].hotel_images[0].image;
            // }

            return GestureDetector(
              onTap: (() {}),
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
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
                      ), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 114,
                      child:
                          //FadeInImage(
                          //     fit: BoxFit.fill,
                          //     image: NetworkImage(
                          //         'http://api.mahmoudtaha.com/images/$imageName'),
                          //     placeholder: AssetImage(
                          //       'assets/images/hotel.jpg',
                          //     ))

                          Image.asset(
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
                            hotelslistWidegt[index]
                                .name
                                .toString(), //HOTEL NAME
                            style: TextStyle(
                                //fontFamily: ,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            hotelslistWidegt[index]
                                .address
                                .toString(), // HOTEL ADRESS
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
                                        color: AppColors.primaryColor,
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
                                          hotelslistWidegt[index]
                                              .rate), // HOTEL RATING
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.4),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
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
                                    '\$${hotelslistWidegt[index].price.toString()}', //HOTEL PRICE PER NIGHT
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
          },
          itemCount: hotelslistWidegt.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
            );
          },
        ),
      );
    });
  }
}
