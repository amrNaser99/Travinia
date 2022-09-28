import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/home/widgets/app_bar/image_slider.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

import '../../../../core/utils/routes.dart';

class HomeAppBar extends StatelessWidget {
  final bool textAndButtonVisibilty;
  const HomeAppBar({super.key, required this.textAndButtonVisibilty});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        expandedHeight: AppHeight.h350,
        collapsedHeight: AppHeight.h150,
        title: GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.exploreHotels),
          child: AbsorbPointer(
            child: CustomTextField(
              hintText: "where are you going?",
              validatorText: "Error!",
              controller: TextEditingController(),
              inputType: TextInputType.none,
              prefixIcon: Icons.search_outlined,
            ),
          ),
        ),
        flexibleSpace: HomeImageSlider(
          textAndButtonVisibilty: textAndButtonVisibilty,
        ));
  }
}
