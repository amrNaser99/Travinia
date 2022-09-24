import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';
import 'package:travinia/presentation/test/widgets/app_bar/home_image_slider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: AppHeight.h300,
      toolbarHeight: AppHeight.h100,
      title: CustomTextField(
        hintText: "where are you going?",
        validatorText: "asd",
        controller: TextEditingController(),
        inputType: TextInputType.emailAddress,
        prefixIcon: Icons.search_outlined,
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: HomeImageSlider(),
      ),
    );
  }
}
