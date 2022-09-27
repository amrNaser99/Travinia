import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_values.dart';

class HotelRating extends StatelessWidget {
  final String rate;
  const HotelRating({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
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
    );
  }
}
