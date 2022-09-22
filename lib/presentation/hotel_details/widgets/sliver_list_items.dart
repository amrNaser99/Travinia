import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_spaces.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/app_values.dart';
import '../../../models/hotel_model.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/custom_text.dart';
import 'overall_rate_conatainer.dart';

class SliverListItems extends StatelessWidget {
  final HotelModel hotelModel;
  const SliverListItems({Key? key, required this.hotelModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeHeadText(text: hotelModel.name),
                      Row(
                        children: [
                          SecondaryText(
                            text: 'Wembley, London',
                            size: AppSize.s10,
                          ),
                          Icon(
                            Icons.location_on,
                            color: AppColors.appColor,
                          ),
                          SecondaryText(
                            text: '2.0 Km to city',
                            size: AppSize.s10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LargeHeadText(text: '\$180'),
                      Padding(
                        padding: EdgeInsets.only(top: AppHeight.h5),
                        child: SecondaryText(
                            text: '/per night', size: AppSize.s10),
                      )
                    ],
                  ),
                ],
              ),
              AppSpaces.vSpace10,
              Divider(
                thickness: 0.6,
              ),
              AppSpaces.vSpace10,
              SmallHeadText(text: 'Summary'),
              AppSpaces.vSpace10,
              Opacity(
                opacity: 0.7,
                child: ReadMoreText(
                  'Featuring a fitness center, Grand Royal Park Hotle is Located in sweden, 4.7 Km from National museum Featuring a fitness center, Grand Royal Park Hotle is Located in sweden, 4.7 Km from National museum ',
                  trimLines: 3,
                  colorClickableText: AppColors.teal,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Read less',
                  style: TextStyle(
                    fontSize: AppSize.s13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              AppSpaces.vSpace20,
              Card(
                elevation: 5.0,
                shadowColor: AppColors.black.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TealText(text: '8.8', size: AppSize.s30),
                          AppSpaces.hSpace20,
                          AppSpaces.hSpace5,
                          SmallHeadText(
                            text: 'Overall rating',
                            size: AppSize.s12,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallHeadText(text: 'Room', size: AppSize.s12),
                              SmallHeadText(
                                  text: 'Services', size: AppSize.s12),
                              SmallHeadText(
                                  text: 'Location', size: AppSize.s12),
                              SmallHeadText(text: 'Price', size: AppSize.s12),
                            ],
                          ),
                          AppSpaces.hSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OverAllRateContainer(width: AppWidth.w150),
                              OverAllRateContainer(width: AppWidth.w100),
                              OverAllRateContainer(width: AppWidth.w50),
                              OverAllRateContainer(width: AppWidth.w100),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppSpaces.vSpace20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallHeadText(text: 'Photos', size: AppSize.s13),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        TealText(
                          text: 'View all ',
                          size: AppSize.s12,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: AppSize.s19,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: AppHeight.h100,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  start: index == 0 ? 20 : 10,
                  end: index == 4 ? 20 : 0,
                ),
                child: Card(
                  elevation: 3.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      width: 110,
                      AppStrings.hotelImgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Divider(
                thickness: 0.6,
              ),
              AppSpaces.vSpace20,
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  AppStrings.mapPreviewImgPath,
                ),
              ),
              AppSpaces.vSpace20,
              CustomButton(
                text: 'Book now',
                onPressed: () {},
                fillColor: AppColors.appColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}
