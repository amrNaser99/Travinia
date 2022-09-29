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
        return Stack(
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
        );
      },
    );
  }
}
