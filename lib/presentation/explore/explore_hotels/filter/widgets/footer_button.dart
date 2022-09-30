import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/extensions/navigation_ext.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';

class FooterButton extends StatelessWidget {
  final dynamic maxPrice;
  final dynamic minPrice;
  final ExploreCubit cubit;
  const FooterButton({
    super.key,
    required this.maxPrice,
    required this.minPrice,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 3,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  cubit.filterOnPricesRangeHotels(
                    maxPrice: maxPrice,
                    minPrice: minPrice,
                  );
                  context.pop;
                },
                child: Text(
                  'Apply',
                  style: getMediumStyle(
                    fontColor: AppColors.white,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
