import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class HotelDistanceAndRating extends StatelessWidget {
  final String rate;
  final String distance;
  const HotelDistanceAndRating(
      {super.key, required this.rate, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_sharp,
              color: AppColors.appColor,
              size: AppSize.s17,
            ),
            Flexible(
              child: SecondaryText(
                text: ' ${AppConst.handleLargeNumbers(distance)} km to city',
                size: FontSize.s12,
                isLight: true,
                isEllipsis: false,
              ),
            )
          ],
        ),
        RatingBar.builder(
          itemSize: AppSize.s16,
          initialRating: double.parse(rate), // HOTEL RATING
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: Theme.of(context).highlightColor,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: AppColors.appColor,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ],
    );
  }
}
