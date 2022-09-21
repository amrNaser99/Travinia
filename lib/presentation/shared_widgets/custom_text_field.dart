import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
import 'package:travinia/core/utils/font_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isEmailField;
  final bool isPasswordField;
  final bool obscureText;
  final int? maxlength;
  final String? validatorText;
  final ValueChanged<String>? onChange;
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
    required this.inputType,
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
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
