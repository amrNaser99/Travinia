import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/custom_didvider.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/switch_tile.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class Accommodation extends StatelessWidget {
  const Accommodation({super.key});

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
            text: 'type of Accommodation',
            size: FontSize.s18,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppWidth.w30, vertical: AppWidth.w10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Switcher(
                  text: 'All',
                ),
                cDivider(),
                Switcher(
                  text: 'Apartment',
                ),
                Switcher(
                  text: 'Home',
                ),
                Switcher(
                  text: 'Villa',
                ),
                Switcher(
                  text: 'Hotel',
                ),
                Switcher(
                  text: 'Resort',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
