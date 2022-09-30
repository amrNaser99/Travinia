import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_strings.dart';
import 'package:travinia/core/utils/app_values.dart';

class HotelImage extends StatelessWidget {
  final String imagePath;
  const HotelImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: AppHeight.h130,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.s16),
            bottomLeft: Radius.circular(AppSize.s16),
          ),
          child: Image.network(
            AppStrings.networkImgPath + imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
