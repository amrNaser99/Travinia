import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isEmailField;
  final bool isPasswordField;
  final bool obscureText;
  final int? maxlength;
  final String? validatorText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFeildSubmitted;
  final TextEditingController controller;
  final TextInputType inputType;

  CustomTextField({
    Key? key,
    required this.hintText,
    this.maxlength,
    this.isEmailField = false, //default,
    this.isPasswordField = false, //default,
    this.obscureText = false,
    required this.validatorText,
    required this.controller,
    this.onChange,
    this.onFeildSubmitted,
    required this.inputType,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      maxLength: maxlength,
      style: getSemiBoldStyle(
          fontColor: Theme.of(context).textTheme.bodyLarge!.color!),
      validator: (value) {
        if (isEmailField) {
          if (!EmailValidator.validate(value!.trim()) && value.isNotEmpty) {
            return 'Email is invalid!';
          } else if (value.isEmpty) {
            return validatorText;
          }
        } else if (isPasswordField) {
          if (estimatePasswordStrength(value!) <= 0.3 && value.isNotEmpty) {
            return 'Password is too weak!';
          } else if (value.isEmpty) {
            return validatorText;
          }
        } else {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
        }
        return null;
      },
      onChanged: onChange,
      onFieldSubmitted: onFeildSubmitted,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.appColor,
                  size: AppSize.s20,
                )
              : null),
    );
  }
}
