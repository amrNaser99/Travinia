import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/utils/extensions/navigation_ext.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/explore_hotels/explore_hotel_screen.dart';
import 'package:travinia/presentation/explore/explore_on_map/bloc/map_cubit.dart';
import 'package:travinia/presentation/explore/explore_on_map/widgets/google_map_widget.dart';
import 'package:travinia/presentation/home/widegts/hotel_data_widget.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_fonts.dart';
import '../../../core/utils/app_spaces.dart';
import '../../../core/utils/app_values.dart';
import '../../shared_widgets/custom_text.dart';
import '../../shared_widgets/custom_text_field.dart';
import '../bloc/explore_cubit.dart';

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
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        ExploreCubit cubit = ExploreCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppHeight.h150),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.pop;
                },
                icon: Icon(FontAwesomeIcons.arrowLeftLong),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.view_agenda_outlined,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExploreHotelScreen(),
                      ),
                    );
                  },
                ),
                AppSpaces.hSpace10,
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                expandedTitleScale: 1,
                centerTitle: true,
                title: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppSize.s16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: AppSize.s16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CustomTextField(
                                    hintText: 'London',
                                    validatorText: 'Please fill the Field',
                                    controller:
                                    BlocProvider.of<ExploreCubit>(context)
                                        .searchController,
                                    inputType: TextInputType.text,
                                    onFeildSubmitted: (value) {
                                      cubit.searchHotels(text: value);
                                    },
                                  ),
                                ),
                              ),
                              AppSpaces.hSpace10,
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.magnifyingGlassLocation,
                                    color: Colors.grey,
                                    size: AppSize.s22,
                                  ),
                                  onPressed: () {
                                    cubit.searchHotels(
                                        text: cubit.searchController.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                cubit.changeDateRange();
                              },
                              child: Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      LargeHeadText(
                                        text: 'Choose Date',
                                        size: FontSize.s16,
                                      ),
                                      SmallHeadText(
                                        text:
                                        '${DateFormat.MMMd().format(DateTime.now())} - ${DateFormat.MMMd().format(DateTime.now().add(Duration(days: 3)))}',
                                        size: FontSize.s14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: AppColors.grey,
                            ),
                            InkWell(
                              onTap: () {
                                ///TODO: Add Guest Picker
                                // cubit.changeGuest();
                              },
                              child: Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSize.s16),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      LargeHeadText(
                                        text: 'Number of Room',
                                        size: FontSize.s16,
                                      ),
                                      SmallHeadText(
                                        text: '2 Room, 1 People',
                                        size: FontSize.s14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Stack(
            children: [

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
                            value = MapCubit.get(context).pageController.page! -
                                index;
                            value = (1 - (value.abs() * 0.3) + 0.06)
                                .clamp(0.0, 1.0);
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
                          padding: const EdgeInsets.only(left: 25, bottom: 30),
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
                                .roundToDouble()),
                            //ToDo: calculate HOTEL far distance
                            hotelPrice: hotelData[index].price,
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
      },
    );
  }
}
