import 'package:flutter/material.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/presentation/explore/explore_on_map/bloc/map_cubit.dart';
import 'package:travinia/presentation/explore/explore_on_map/widgets/google_map_widget.dart';
import 'package:travinia/presentation/home/widegts/hotel_data_widget.dart';

class ExploreOnMap extends StatefulWidget {
  ExploreOnMap({super.key});

  @override
  State<ExploreOnMap> createState() => _ExploreOnMapState();
}

class _ExploreOnMapState extends State<ExploreOnMap> {
  @override
  void initState() {
    super.initState();
    MapCubit.get(context).initPagecontroler(context);

    //   ..addListener(MapCubit.get(context).onScroll(context));
    // ;
  }

  @override
  Widget build(BuildContext context) {
    List hotelData = AppCubit.get(context).hotels;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          // Con(
          //   color: Colors.teal,
          //   width: 200,
          //   height: 60,
          //   child: Center(child: Text('testing the map')),
          // ),
          GoogleMapWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 150,
              child: PageView.builder(
                onPageChanged: (value) {
                  MapCubit.get(context).onScroll(context);
                },
                controller: MapCubit.get(context).pageController,
                itemCount: hotelData.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedBuilder(
                    animation: MapCubit.get(context).pageController,
                    builder: (BuildContext context, Widget? widget) {
                      double value = 1;
                      if (MapCubit.get(context)
                          .pageController
                          .position
                          .haveDimensions) {
                        value =
                            MapCubit.get(context).pageController.page! - index;
                        value =
                            (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeInOut.transform(value) * 150.0,
                          width: Curves.easeInOut.transform(value) * 400.0,
                          child: widget,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 30),
                      child: HotelDataWidget(
                        width: 300,
                        hotelName: hotelData[index].name,
                        hotelAdress: hotelData[index].address,
                        distance: (AppCubit.get(context)
                            .CalcDistanceOfGeocoordinates(
                              startLatitude: AppCubit.get(context).myLat,
                              startLongitude: AppCubit.get(context).myLong,
                              endLatitude:
                                  double.parse(hotelData[index].latitude),
                              endLongitude:
                                  double.parse(hotelData[index].longitude),
                            )
                            .roundToDouble()), //ToDo: calculate HOTEL far distance
                        // hotelPrice: hotelData[index].price,
                        hotelRating: hotelData[index].rate,
                      ),
                    ),
                  );
                  // return Padding(
                  //   padding: const EdgeInsets.only(left: 25, bottom: 30),
                  //   child: HotelDataWidget(
                  //     width: 320,
                  //     hotelName: hotelData[index].name,
                  //     hotelAdress: hotelData[index].address,
                  //     distance: (AppCubit.get(context)
                  //         .CalcDistanceOfGeocoordinates(
                  //           startLatitude: AppCubit.get(context).myLat,
                  //           startLongitude: AppCubit.get(context).myLong,
                  //           endLatitude:
                  //               double.parse(hotelData[index].latitude),
                  //           endLongitude:
                  //               double.parse(hotelData[index].longitude),
                  //         )
                  //         .roundToDouble()), //ToDo: calculate HOTEL far distance
                  //     hotelPrice: hotelData[index].price,
                  //     hotelRating: hotelData[index].rate,
                  //   ),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
