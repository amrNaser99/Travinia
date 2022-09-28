import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/extensions/navigation_ext.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_hotels_image.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_search_image.dart';
import 'package:travinia/presentation/explore/explore_on_map/explore_map_screen.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/routes.dart';
import '../../bloc/explore_cubit.dart';

class ExploreHotelAppBar extends StatefulWidget {
  final List<HotelModel> hotelData;

  const ExploreHotelAppBar({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

  @override
  State<ExploreHotelAppBar> createState() => _ExploreHotelAppBarState();
}

class _ExploreHotelAppBarState extends State<ExploreHotelAppBar> {
  @override
  Widget build(BuildContext context) {
    ExploreCubit cubit = BlocProvider.of<ExploreCubit>(context);

    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        return CustomScrollView(
          controller: BlocProvider.of<ExploreCubit>(context).scrollController,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              expandedHeight: AppHeight.h250,
              stretch: true,
              floating: true,
              pinned: true,
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
                    FontAwesomeIcons.mapLocation,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExploreOnMap(),
                      ),
                    );
                  },
                ),
                AppSpaces.hSpace10,
              ],
              primary: true,
              snap: true,
              bottom: PreferredSize(
                preferredSize: Size(
                  MediaQuery.of(context).size.width,
                  AppHeight.h60,
                ),
                child: Column(
                  children: [
                    Divider(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSize.s16),
                            child: Row(
                              children: [
                                ConditionalBuilder(
                                  condition: cubit.hotelResults.isNotEmpty,
                                  builder: (context) => Expanded(
                                    flex: 2,
                                    child: SmallHeadText(
                                      text:
                                          '${cubit.hotelResults.length} Hotel Found',
                                      size: FontSize.s13,
                                    ),
                                  ),
                                  fallback: (BuildContext context) => Expanded(
                                    flex: 2,
                                    child: SmallHeadText(
                                      text:
                                          '${widget.hotelData.length} Hotel Found',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
            ConditionalBuilder(
              condition: cubit.hotelResults.length > 0,
              builder: (context) {
                return buildSearchList(hotelResults: cubit.hotelResults);
              },
              fallback: (BuildContext context) {
                return buildHotelsImage(hotelData: widget.hotelData);
              },
            ),
          ],
        );
      },
    );
  }
}
