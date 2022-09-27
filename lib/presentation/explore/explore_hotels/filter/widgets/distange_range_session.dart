import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class DistanceRangeSession extends StatefulWidget {
  const DistanceRangeSession({
    Key? key,
  }) : super(key: key);

  @override
  _DistanceRangeSessionState createState() => _DistanceRangeSessionState();
}

class _DistanceRangeSessionState extends State<DistanceRangeSession> {
  double _value = 6;
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
            text: 'Distance from city center',
            size: FontSize.s18,
          ),
        ),
        SizedBox(
          height: AppHeight.h20,
        ),
        Slider(
          inactiveColor: Theme.of(context).dividerColor,
          max: 10,
          min: 0,
          divisions: 5,
          value: _value,
          label: _value.toString(),
          //  RangeLabels(_currentRangeValues.start.toStringAsFixed(1),
          //     _currentRangeValues.end.toStringAsFixed(0)),
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
              print(newValue);
            });
          },
        ),
      ],
    );
  }
}
