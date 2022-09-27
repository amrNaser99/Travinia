import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/checkboxlabel.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class PopularFilter extends StatelessWidget {
  const PopularFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppWidth.w25,
            top: AppWidth.w20,
          ),
          child: SecondaryText(
            text: 'Popular filter',
            size: FontSize.s18,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppWidth.w20, vertical: AppWidth.w10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckBoxLabel(
                      text: 'Free Breakfast',
                    ),
                    CheckBoxLabel(
                      text: 'free Parking',
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckBoxLabel(
                      text: 'Pool',
                    ),
                    CheckBoxLabel(
                      text: 'Pet Friendly',
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckBoxLabel(
                      text: 'Free Wifi',
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
