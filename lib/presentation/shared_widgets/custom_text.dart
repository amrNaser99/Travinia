import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  const PrimaryText(
      {super.key, required this.text, this.size, this.center = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: size ?? FontSize.s16,
          ),
      textAlign: center ? TextAlign.center : null,
    );
  }
}

class SecondaryText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  const SecondaryText(
      {super.key, required this.text, this.size, this.center = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: size ?? FontSize.s14,
          ),
      textAlign: center ? TextAlign.center : null,
    );
  }
}

class TealText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  const TealText(
      {super.key, required this.text, this.size, this.center = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.teal,
            fontSize: size ?? FontSize.s14,
          ),
      textAlign: center ? TextAlign.center : null,
    );
  }
}
