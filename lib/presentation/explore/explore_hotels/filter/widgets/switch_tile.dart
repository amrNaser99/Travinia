import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';

class Switcher extends StatefulWidget {
  Switcher({super.key, required this.text});
  final String text;
  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: TextStyle(
                fontSize: FontSize.s16, fontWeight: FontWeightManager.medium),
          ),
          CupertinoSwitch(
            activeColor: AppColors.teal,
            onChanged: (value) => setState(() {
              this.value = value;
            }),
            value: value,
          ),
        ],
      ),
    );
  }

  Widget buildSwitch() => CupertinoSwitch(
      activeColor: Colors.teal,
      value: value,
      onChanged: ((value) => setState(() {
            this.value = value;
          })));
}
