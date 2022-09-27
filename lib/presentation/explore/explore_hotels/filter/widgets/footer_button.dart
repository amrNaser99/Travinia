import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/font_styles.dart';

class FooterButton extends StatelessWidget {
  const FooterButton({super.key});

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
                onPressed: () {},
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
