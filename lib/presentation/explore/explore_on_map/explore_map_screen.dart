import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/utils/extensions/navigation_ext.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/explore_on_map/bloc/map_cubit.dart';
import 'package:travinia/presentation/explore/explore_on_map/widgets/google_map_widget.dart';
import 'package:travinia/presentation/home/body/hotel_card_info.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_contstants.dart';
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
            preferredSize: Size.fromHeight(AppHeight.h180),
            child: AppBar(
              leadingWidth: double.infinity,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop;
                    },
                    icon: Icon(Icons.adaptive.arrow_back),
                  ),
                  LargeHeadText(text: 'Explore'),
                ],
              ),
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
                    Icons.menu,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSpaces.vSpace20,
                      AppSpaces.vSpace20,
                      AppSpaces.vSpace20,
                      AppSpaces.vSpace20,
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: AppSize.s16),
                              child: Container(
                                height: 50,
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
                                    cubit.searchHotels(text: value);
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                            child: RawMaterialButton(
                              onPressed: () {},
                              elevation: 0.0,
                              fillColor: AppColors.appColor,
                              shape: CircleBorder(),
                              child: Icon(
                                color: AppColors.white,
                                Icons.search_rounded,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                      text: 'Choose Date',
                                      size: FontSize.s13,
                                    ),
                                    AppSpaces.vSpace10,
                                    SmallHeadText(
                                      text:
                                          '${DateFormat.MMMd().format(DateTime.now())} - ${DateFormat.MMMd().format(DateTime.now().add(Duration(days: 3)))}',
                                      size: FontSize.s13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    AppSpaces.hSpace20,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PrimaryText(
                                          text: 'Number of Room',
                                          size: FontSize.s14,
                                        ),
                                        AppSpaces.vSpace10,
                                        SmallHeadText(
                                          text: '2 Room, 1 People',
                                          size: FontSize.s14,
                                        ),
                                      ],
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
                            hotel: hotelData[index],
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
