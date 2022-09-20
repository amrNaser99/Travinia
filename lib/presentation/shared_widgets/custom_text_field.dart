import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isEmailField;
  final bool isPasswordField;
  final bool obscureText;
  final int? maxlength;
  final String? validatorText;
  final ValueChanged<String>? onChange;
  final TextEditingController textController;

  CustomTextField({
    Key? key,
    required this.hintText,
    this.maxlength,
    this.isEmailField = false, //default,
    this.isPasswordField = false, //default,
    this.obscureText = false,
    required this.validatorText,
    required this.textController,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText ? true : false,
      maxLength: maxlength,
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
