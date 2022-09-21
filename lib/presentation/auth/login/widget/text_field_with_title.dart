import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

class TextFieldWithTitle extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType inputType;
  final bool obscure;
  const TextFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.inputType,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
          child: SecondaryText(text: title, isLight: true),
        ),
        SizedBox(height: AppHeight.h3),
        CustomTextField(
          hintText: hint,
          validatorText: "ERROR",
          controller: controller,
          inputType: inputType,
          obscureText: obscure,
        ),
      ],
    );
  }
}
