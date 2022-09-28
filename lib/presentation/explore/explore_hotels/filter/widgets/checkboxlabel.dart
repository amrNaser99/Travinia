import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_fonts.dart';

class CheckBoxLabel extends StatefulWidget {
  CheckBoxLabel({super.key, required this.text});
  final String text;

  @override
  State<CheckBoxLabel> createState() => _CheckBoxLabelState();
}

class _CheckBoxLabelState extends State<CheckBoxLabel> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              side: BorderSide(color: Theme.of(context).dividerColor),
              value: isChecked,
              onChanged: ((value) {
                setState(() => isChecked = value!);
              }),
            ),
            Expanded(
              child: Text(
                widget.text,
                style: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.medium),
              ),
            )
          ],
        ),
      ),
    );
  }
}
