import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_hotels_image.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_search_image.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_hotel_view_or_map.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_on_map/bloc/map_cubit.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_on_map/bloc/map_state.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_on_map/explore_map_screen.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_on_map/widgets/google_map_widget.dart';
import 'package:travinia/presentation/home/body/hotel_card_info.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';
import 'dart:math' as math;

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
  Widget build(BuildContext context) {
    ExploreCubit cubit = BlocProvider.of<ExploreCubit>(context);

    return BlocBuilder<MapCubit, MapStates>(
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
                  Navigator.pushReplacementNamed(context, Routes.exploreOnMap);
                },
              ),
              AppSpaces.hSpace10,
            ],
          ),
          body: Stack(
            children: [
              Container(
                height: AppHeight.h55,
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.s10,
                  horizontal: AppSize.s10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: AppConst.shadow,
                        ),
                        child: CustomTextField(
                          hintText: 'London...',
                          validatorText: 'Please fill the Field',
                          controller: BlocProvider.of<ExploreCubit>(context)
                              .searchController,
                          inputType: TextInputType.text,
                          onFeildSubmitted: (value) {
                            cubit.searchHotels(text: value);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        alignment: AlignmentDirectional.centerEnd,
                        child: RawMaterialButton(
                          onPressed: () {
                            cubit.searchHotels(
                                text: cubit.searchController.text);
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
                    ),
                  ],
                ),
              ),
              Container(
                height: AppHeight.h55,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.changeDateRange();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                    Container(
                      height: double.infinity,
                      width: 1,
                      color: Theme.of(context).canvasColor,
                    ),
                    InkWell(
                      onTap: () {
                        // cubit.changeGuest();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: AppWidth.w20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                height: 30,
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ConditionalBuilder(
                        condition: cubit.hotelResults.isNotEmpty,
                        builder: (context) => SmallHeadText(
                          text: '${cubit.hotelResults.length} Hotel Found',
                          size: FontSize.s13,
                        ),
                        fallback: (BuildContext context) => SmallHeadText(
                          text: '${widget.hotelData.length} Hotel Found',
                          size: FontSize.s13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.filter,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmallHeadText(
                                text: 'Filter', size: FontSize.s14),
                            AppSpaces.hSpace10,
                            Icon(
                              Icons.filter_list_outlined,
                              color: AppColors.appColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                      itemCount: widget.hotelData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimatedBuilder(
                          animation: MapCubit.get(context).pageController,
                          builder: (BuildContext context, Widget? widget) {
                            double value = 1;
                            if (MapCubit.get(context)
                                .pageController
                                .position
                                .haveDimensions) {
                              value = MapCubit.get(context)
                                  .pageController
                                  .page! -
                                  index;
                              value = (1 - (value.abs() * 0.3) + 0.06)
                                  .clamp(0.0, 1.0);
                            }
                            return Center(
                              child: SizedBox(
                                height: Curves.easeInOut.transform(value) *
                                    150.0,
                                width: Curves.easeInOut.transform(value) *
                                    400.0,
                                child: widget,
                              ),
                            );
                          },
                          child: HotelCardInfo(
                            hotel: widget.hotelData[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
