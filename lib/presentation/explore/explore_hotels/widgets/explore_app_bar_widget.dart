import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/explore_hotel_view_or_map.dart';

import '../../../../core/utils/app_spaces.dart';
import '../../../../models/hotel_model.dart';
import '../../../shared_widgets/custom_text.dart';
import '../../explore_on_map/explore_map_screen.dart';

class ExploreHotelAppBar extends StatelessWidget {
  final List<HotelModel> hotelData;

  const ExploreHotelAppBar({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        ExploreCubit cubit = BlocProvider.of(context);
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
                  FontAwesomeIcons.mapLocation,
                ),
                onPressed: () {
                  debugPrint("in mapLocation icon");

                  cubit.changeBMapClicked;
                },
              ),
              AppSpaces.hSpace10,
            ],
          ),
          body: ExploreHotelViewAndMap(
            hotelData: hotelData,
          ),
        );
      },
    );
  }
}
