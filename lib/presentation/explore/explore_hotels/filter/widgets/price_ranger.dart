import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

import '../../../bloc/explore_cubit.dart';

class priceRangeSession extends StatefulWidget {
  final ExploreCubit exploreCubit;
  const priceRangeSession({
    Key? key,
    required this.exploreCubit,
  }) : super(key: key);

  @override
  _priceRangeSessionState createState() => _priceRangeSessionState();
}

class _priceRangeSessionState extends State<priceRangeSession> {
  RangeValues _currentRangeValues = const RangeValues(50, 4000);
  SfRangeValues _values = SfRangeValues(50, 4000);
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
            text: 'price(for 1 night)',
            size: FontSize.s18,
          ),
        ),
        SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
            tooltipBackgroundColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
            activeTrackColor: Colors.transparent,
            thumbColor: Colors.transparent,
            thumbRadius: 28,
          ),
          child: SfRangeSlider(
            min: 30,
            max: 5000,
            values: _values,
            interval: 20,
            showTicks: false,
            showLabels: false,
            enableTooltip: false,
            shouldAlwaysShowTooltip: false,
            minorTicksPerInterval: 1,
            startThumbIcon: Container(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('\$${_values.start.round().toString()}'))),
            endThumbIcon: Container(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('\$${_values.end.round().toString()}'))),
            onChanged: (SfRangeValues values) {
              setState(() {
                _values = values;
                widget.exploreCubit.maxPrice = _values.end;
                widget.exploreCubit.minPrice = _values.start;
              });
            },
          ),
        ),
        SfRangeSlider(
          min: 30,
          max: 5000,
          values: _values,
          interval: 20,
          showTicks: false,
          showLabels: false,
          enableTooltip: false,
          shouldAlwaysShowTooltip: false,
          inactiveColor: Theme.of(context).dividerColor,
          minorTicksPerInterval: 1,
          onChanged: (SfRangeValues values) {
            setState(() {
              _values = values;
              widget.exploreCubit.maxPrice = _values.end;
              widget.exploreCubit.minPrice = _values.start;
            });
          },
        ),
      ],
    );
  }
}
