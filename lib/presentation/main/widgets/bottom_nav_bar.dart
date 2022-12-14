import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_values.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(bottom: AppHeight.h1),
          child: DotNavigationBar(
            curve: Curves.easeIn,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavBar(index: index);
            },
            marginR: EdgeInsets.symmetric(horizontal: AppWidth.w20)
                .add(EdgeInsets.only(bottom: AppHeight.h2)),
            dotIndicatorColor: Colors.transparent,
            selectedItemColor: AppColors.teal,
            unselectedItemColor: AppColors.grey.withOpacity(0.7),
            backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
            itemPadding: EdgeInsets.only(
              left: AppWidth.w20,
              right: AppWidth.w20,
              top: AppHeight.h5,
            ),
            borderRadius: AppSize.s50,
            items: [
              DotNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: AppSize.s24,
                ),
              ),
              DotNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline_outlined,
                  size: AppSize.s24,
                ),
              ),
              DotNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                  size: AppSize.s24,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
