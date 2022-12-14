import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/extensions/height_ext.dart';
import 'package:travinia/core/utils/extensions/navigation_ext.dart';
import 'package:travinia/presentation/explore/hotel_details/cubit/hotel_details_page_cubit.dart';
import 'package:travinia/presentation/explore/hotel_details/widgets/flexable_space_bar.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_values.dart';
import '../../../../models/hotel_model.dart';

class SliverAppBarWidget extends StatelessWidget {
  final HotelDetailsPageCubit hotelDetailsCubit;
  final HotelModel hotelModel;
  final BuildContext hotelDetailsScreenContext;
  const SliverAppBarWidget({
    Key? key,
    required this.hotelDetailsCubit,
    required this.hotelModel,
    required this.hotelDetailsScreenContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.height,
      pinned: true,
      collapsedHeight: AppHeight.h90,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      leadingWidth: 90,
      leading: Padding(
        padding: EdgeInsets.only(top: AppHeight.h5),
        child: RawMaterialButton(
          shape: CircleBorder(),
          elevation: 0.0,
          fillColor: Colors.black26,
          onPressed: () {
            context.pop;
          },
          child: Icon(
            Icons.adaptive.arrow_back,
            color: AppColors.white,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: AppHeight.h5),
          child: RawMaterialButton(
            shape: CircleBorder(),
            elevation: 0.0,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            onPressed: () {},
            child: Icon(
              Icons.favorite_outline_rounded,
              color: AppColors.teal,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexableSpaceBarWidget(
        hotelDetailsCubit: hotelDetailsCubit,
        hotelModel: hotelModel,
        hotelDetailsScreenContext: hotelDetailsScreenContext,
      ),
    );
  }
}
