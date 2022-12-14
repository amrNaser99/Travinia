import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_hotels_image.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_search_image.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_contstants.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_spaces.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../core/utils/routes.dart';
import '../../../../models/hotel_model.dart';
import '../../../shared_widgets/custom_text.dart';
import '../../../shared_widgets/custom_text_field.dart';
import 'dart:math' as math;

class ExploreHotelViewAndMap extends StatefulWidget {
  final List<HotelModel> hotelData;

  const ExploreHotelViewAndMap({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

  @override
  State<ExploreHotelViewAndMap> createState() => _ExploreHotelViewAndMapState();
}

class _ExploreHotelViewAndMapState extends State<ExploreHotelViewAndMap> {
  @override
  Widget build(BuildContext context) {
    ExploreCubit cubit = BlocProvider.of<ExploreCubit>(context);

    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: SliverAppBarDelegate(
                minHeight: AppHeight.h80,
                maxHeight: AppHeight.h80,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppSize.s20,
                    top: AppSize.s15,
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
                            controller: BlocProvider.of<ExploreCubit>(context)
                                .searchController,
                            inputType: TextInputType.text,
                            onFeildSubmitted: (value) {
                              cubit.searchHotels(text: value);
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
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                minHeight: AppHeight.h60,
                maxHeight: AppHeight.h60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          cubit.changeDateRange();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppWidth.w20),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ),
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: AppHeight.h30,
                maxHeight: AppHeight.h30,
                child: Container(
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
                            Navigator.pushNamed(context, Routes.filter,
                                arguments: cubit);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SmallHeadText(text: 'Filter', size: FontSize.s14),
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
              ),
            ),
            BlocBuilder<ExploreCubit, ExploreState>(
              builder: (context, state) {
                if (state is HotelsLoadingState ||
                    state is SearchHotelsLoadingState)
                  return SliverPersistentHeader(
                      delegate: SliverAppBarDelegate(
                          minHeight: MediaQuery.of(context).size.height * 0.65,
                          maxHeight: MediaQuery.of(context).size.height * 0.65,
                          child: Center(child: CircularProgressIndicator())));
                else if (state is SearchHotelsSuccessState)
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        buildSearchList(
                          hotelResults: cubit.hotelResults,
                        ),
                      ],
                    ),
                  );
                else
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        buildHotelsImage(
                          hotelData: AppCubit.get(context).hotels,
                        ),
                      ],
                    ),
                  );
              },
            ),
          ],
        );
      },
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final progress = shrinkOffset / maxExtent;

// debugPrint('progress => $progress');

    return AnimatedContainer(
      duration: const Duration(seconds: 2),
// height: progress,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
