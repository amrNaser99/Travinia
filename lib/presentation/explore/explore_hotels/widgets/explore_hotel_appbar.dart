import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/extensions/navigation_ext.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/explore/explore_hotels/widgets/build_hotels_image.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

import '../../bloc/explore_cubit.dart';

class ExploreHotelAppBar extends StatelessWidget {
  final List<HotelModel> hotelData;

  const ExploreHotelAppBar({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          expandedHeight: AppHeight.h200,
          stretch: true,
          floating: true,
          pinned: true,
          leading: IconButton(
            onPressed: () {
              context.pop;
            },
            icon: Icon(FontAwesomeIcons.arrowLeftLong),
          ),
          title: Text(
            'Explore',
            style: getBoldStyle(
              fontColor: AppColors.white,
              fontSize: AppSize.s20,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.mapLocation,
              ),
              onPressed: () {},
            ),
            AppSpaces.hSpace10,
          ],
          primary: true,
          snap: true,
          bottom: PreferredSize(
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              AppHeight.h90,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.lightGrey,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '530 Hotel Found',
                              style:
                                  getSemiBoldStyle(fontColor: AppColors.white),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () {},
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Filter'),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      ///TODO
                                      Icons.filter_list_outlined,
                                      color: AppColors.appColor,
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///TODO
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppWidth.w20,
              ),
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
                        controller: BlocProvider.of<ExploreCubit>(context)
                            .searchController,
                        inputType: TextInputType.text,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.magnifyingGlassLocation,
                        color: Colors.grey,
                        size: AppSize.s22,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // buildSearchBar(),
          ),
        ),
        buildHotelsImage(hotelData: hotelData),
      ],
    );
  }
}
