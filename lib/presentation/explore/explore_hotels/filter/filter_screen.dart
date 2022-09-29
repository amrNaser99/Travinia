import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/Accommodation.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/custom_didvider.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/distange_range_session.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/footer_button.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/popular_filter.dart';
import 'package:travinia/presentation/explore/explore_hotels/filter/widgets/price_ranger.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class Filter extends StatefulWidget {
  Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        width: double.infinity,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppWidth.w5, top: AppWidth.w30),
                child: IconButton(
                  onPressed: (() => Navigator.pop(context)),
                  icon: Icon(Icons.close),
                  iconSize: AppSize.s26,
                  color: Theme.of(context).focusColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: AppWidth.w18,
                ),
                child: LargeHeadText(
                  text: 'Filtter',
                  size: FontSize.s26,
                ),
              ),
              priceRangeSession(),
              cDivider(horpading: AppWidth.w18),
              PopularFilter(),
              cDivider(horpading: AppWidth.w18),
              DistanceRangeSession(),
              cDivider(horpading: AppWidth.w18),
              Accommodation(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterButton(),
    );
  }
}

