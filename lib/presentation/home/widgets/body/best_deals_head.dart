import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class BestDealsHead extends StatelessWidget {
  const BestDealsHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.w5,
      ),
      child: Row(
        children: [
          LargeHeadText(
            text: "Best Deals",
            size: FontSize.s18,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                TealText(
                  text: "View all",
                  size: FontSize.s13,
                ),
                SizedBox(width: AppWidth.w4),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.appColor,
                  size: 13,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
