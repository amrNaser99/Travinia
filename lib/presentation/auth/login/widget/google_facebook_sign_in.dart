import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';

class GoogleFacebookSignIn extends StatelessWidget {
  const GoogleFacebookSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            fillColor: Colors.indigo,
            text: 'Facebook',
            icon: FontAwesomeIcons.facebook,
            onPressed: () {},
          ),
        ),
        AppSpaces.hSpace10,
        Expanded(
          child: CustomButton(
            fillColor: Colors.red[800],
            text: 'Google',
            icon: FontAwesomeIcons.google,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
