import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_strength/password_strength.dart';

import '../../core/utils/app_contstants.dart';

class CustomTextField extends StatelessWidget {
  final hintText;
  final hintTextColor;
  final isEmailField;
  final isPasswordField;
  final labelText;
  final labelTextColor;
  final obscureText;
  final prifixIcon;
  final borderColor;
  final backgroundColor;
  final double height;
  final maxlength;
  final borderRadius;
  final validatorText;
  final ValueChanged<String>? onChange;
  final TextEditingController textController;

  CustomTextField({
    Key? key,
    this.hintText,
    this.hintTextColor,
    this.labelText,
    this.labelTextColor,
    this.maxlength,
    this.isEmailField = false, //default,
    this.isPasswordField = false, //default,
    this.obscureText,
    this.borderColor,
    this.backgroundColor,
    this.height = 50.0,
    required this.validatorText,
    this.prifixIcon,
    required this.textController,
    this.borderRadius,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 8.0, top: 8.0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: AppConst.shadow,
        color: backgroundColor ?? Colors.white,
      ),
      child: TextFormField(
        controller: textController,
        obscureText: obscureText ?? false,
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
        style: GoogleFonts.workSans(
          color: labelTextColor ?? Colors.black,
          fontSize: 13.0,
        ),
        decoration: InputDecoration(
          prefixIcon: prifixIcon != null
              ? Icon(
                  prifixIcon,
                  color: Colors.black,
                )
              : null,
          labelText: labelText,
          labelStyle: GoogleFonts.workSans(
            color: labelTextColor ?? Colors.black,
            fontSize: 13.0,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.workSans(
            color: hintTextColor ?? Colors.black38,
            fontSize: 13.0,
          ),
          errorStyle: GoogleFonts.workSans(
            fontSize: 13.0,
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppConst.radius),
              borderSide: BorderSide(
                color: borderColor ?? Colors.white,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppConst.radius),
              borderSide: BorderSide(
                color: borderColor ?? Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppConst.radius),
              borderSide: BorderSide(
                color: borderColor ?? Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppConst.radius),
              borderSide: BorderSide(
                color: borderColor ?? Colors.white,
              )),
        ),
      ),
    );
  }
}
