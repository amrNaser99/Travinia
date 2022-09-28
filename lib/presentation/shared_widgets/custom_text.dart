import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';

class LargeHeadText extends StatelessWidget {
  final String text;
  final double? size;
  final bool isEllipsis;
  const LargeHeadText(
      {super.key, required this.text, this.size, this.isEllipsis = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: size ?? FontSize.s16,
          ),
      ///TODO Need To Fix
      overflow: isEllipsis ? TextOverflow.ellipsis : null,

    );
  }
}

class SmallHeadText extends StatelessWidget {
  final String text;
  final double? size;
  final bool isEllipsis;
  const SmallHeadText(
      {super.key, required this.text, this.size, this.isEllipsis = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: size ?? FontSize.s14,
          ),
      overflow: isEllipsis ? TextOverflow.ellipsis : null,
    );
  }
}

class PrimaryText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  final bool isEllipsis;
  const PrimaryText(
      {super.key,
      required this.text,
      this.size,
      this.center = false,
      this.isEllipsis = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: size ?? FontSize.s14,
          ),
      textAlign: center ? TextAlign.center : null,
      overflow: isEllipsis ? TextOverflow.ellipsis : null,
    );
  }
}

class PrimaryWithStaticColorText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  final FontWeight? fontWeight;
  const PrimaryWithStaticColorText(
      {super.key,
      required this.text,
      this.size,
      this.center = false,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
          fontSize: size ?? FontSize.s14,
          color: AppColors.white,
          fontWeight: fontWeight),
      textAlign: center ? TextAlign.center : null,
    );
  }
}

class SecondaryText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  final bool isLight;
  final bool isButton;
  final bool isEllipsis;
  const SecondaryText({
    super.key,
    required this.text,
    this.size,
    this.center = false,
    this.isLight = false,
    this.isButton = false,
    this.isEllipsis = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: size ?? FontSize.s14,
          fontWeight: isButton ? FontWeightManager.semiBold : null,
          color: isLight
              ? Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.8)
              : null),
      textAlign: center ? TextAlign.center : null,
      overflow: isEllipsis ? TextOverflow.ellipsis : null,
    );
  }
}

class TealText extends StatelessWidget {
  final String text;
  final bool center;
  final double? size;
  final bool isEllipsis;
  const TealText(
      {super.key,
      required this.text,
      this.size,
      this.center = false,
      this.isEllipsis = true});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.teal,
            fontSize: size ?? FontSize.s14,
          ),
      textAlign: center ? TextAlign.center : null,
      overflow: isEllipsis ? TextOverflow.ellipsis : null,
    );
  }
}
