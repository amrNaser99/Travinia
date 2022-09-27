import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class cDivider extends StatelessWidget {
  cDivider({super.key, this.horpading = 0});
  final double horpading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horpading),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Theme.of(context).dividerColor,
      ),
    );
  }
}
