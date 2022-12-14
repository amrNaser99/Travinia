import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore_on_map/bloc/map_cubit.dart';
import 'package:travinia/presentation/explore_on_map/bloc/map_state.dart';
import 'package:travinia/presentation/explore_on_map/widgets/google_map_widget.dart';
import 'package:travinia/presentation/home/body/hotel_card_info.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

class ExploreOnMap extends StatefulWidget {
  final List<HotelModel> hotelData;

  const ExploreOnMap({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

  @override
  State<ExploreOnMap> createState() => _ExploreOnMapState();
}

class _ExploreOnMapState extends State<ExploreOnMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExploreCubit cubit = BlocProvider.of<ExploreCubit>(context);

    return BlocProvider(
      create: (context) => MapCubit()..initPagecontroler(context),
      child: BlocBuilder<MapCubit, MapStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: LargeHeadText(text: 'Explore'),
              actions: [
                IconButton(
                  icon: Icon(
                    size: 25.0,
                    Icons.favorite_border_rounded,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.view_agenda_outlined,
                  ),
                  onPressed: () {
                    debugPrint("in mapLocation icon");
                    Navigator.pushReplacementNamed(
                        context, Routes.exploreHotels);
                  },
                ),
                AppSpaces.hSpace10,
              ],
            ),
            body: Stack(
              children: [
                GoogleMapWidget(),
                Column(
                  children: [
                    AppSpaces.expandedSpace,
                    Container(
                      height: AppHeight.h200,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          MapCubit.get(context).onScroll(context);
                        },
                        controller: MapCubit.get(context).pageController,
                        itemCount: cubit.hotelResults.length,
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
                                    MapCubit.get(context).pageController.page! -
                                        index;
                                value = (1 - (value.abs() * 0.3) + 0.06)
                                    .clamp(0.0, 1.0);
                              }
                              return Center(
                                child: SizedBox(
                                  height:
                                      Curves.easeInOut.transform(value) * 150.0,
                                  width:
                                      Curves.easeInOut.transform(value) * 400.0,
                                  child: widget,
                                ),
                              );
                            },
                            child: HotelCardInfo(
                              hotel: cubit.hotelResults[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: AppHeight.h80,
                      padding: EdgeInsets.only(
                        left: AppSize.s20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: AppConst.shadow,
                              ),
                              child: CustomTextField(
                                hintText: 'London...',
                                validatorText: 'Please fill the Field',
                                controller:
                                    BlocProvider.of<ExploreCubit>(context)
                                        .searchController,
                                inputType: TextInputType.text,
                                onFeildSubmitted: (value) {
                                  cubit.searchHotels(text: value.trim());
                                  MapCubit.get(context).onScroll(context);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: RawMaterialButton(
                              onPressed: () {
                                cubit.searchHotels(
                                    text: cubit.searchController.text);
                                MapCubit.get(context).onScroll(context);
                              },
                              elevation: 0.0,
                              fillColor: AppColors.appColor,
                              shape: CircleBorder(),
                              child: Icon(
                                color: AppColors.white,
                                Icons.search_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: AppHeight.h60,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.changeDateRange();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppWidth.w20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmallHeadText(
                                    text: 'Choose Date',
                                    size: FontSize.s13,
                                  ),
                                  AppSpaces.vSpace10,
                                  SecondaryText(
                                    text:
                                        '${DateFormat.MMMd().format(DateTime.now())} - ${DateFormat.MMMd().format(DateTime.now().add(Duration(days: 3)))}',
                                    size: FontSize.s13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // cubit.changeGuest();
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: 1,
                                  color: Theme.of(context).canvasColor,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppWidth.w20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmallHeadText(
                                        text: 'Number of Room',
                                        size: FontSize.s14,
                                      ),
                                      AppSpaces.vSpace10,
                                      SecondaryText(
                                        text: '2 Room, 1 People',
                                        size: FontSize.s14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
