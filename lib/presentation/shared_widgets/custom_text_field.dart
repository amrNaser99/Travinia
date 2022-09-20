import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String? hintText;
//   final Color? hintTextColor;
//   final bool isEmailField;
//   final bool isPasswordField;
//   final String? labelText;
//   final Color? labelTextColor;
//   final bool obscureText;
//   final IconData? prefixIcon;
//   final Color? borderColor;
//   final Color? backgroundColor;
//   final double height;
//   final maxLength;
//   final borderRadius;
//   final validatorText;
//   final TextInputAction? textInputAction;
//   final ValueChanged<String>? onChange;
//   final TextEditingController textController;
//
//   CustomTextField({
//     Key? key,
//     this.hintText,
//     this.hintTextColor,
//     this.labelText,
//     this.labelTextColor,
//     this.maxLength,
//     this.isEmailField = false, //default,
//     this.isPasswordField = false, //default,
//     this.obscureText = false, //default,
//     this.borderColor,
//     this.backgroundColor,
//     this.height = 50.0,
//     required this.textController,
//     required this.validatorText,
//     this.prefixIcon,
//     this.textInputAction,
//     required this.borderRadius,
//     this.onChange,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // padding: EdgeInsetsDirectional.only(
//       //   start: 8.0,
//       //   top: 8.0,
//       // ),
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: AppConst.shadow,
//         color: backgroundColor ?? Colors.white,
//       ),
//       child: TextFormField(
//         controller: textController,
//         obscureText: obscureText ? true : false,
//         maxLength: maxLength,
//         textInputAction: textInputAction,
//         keyboardType: isEmailField
//             ? TextInputType.emailAddress
//             : isPasswordField
//                 ? TextInputType.visiblePassword
//                 : TextInputType.text,
//         validator: (value) {
//           if (isEmailField) {
//             if (!EmailValidator.validate(value!.trim()) && value.isNotEmpty) {
//               return 'Email is invalid!';
//             } else if (value.isEmpty) {
//               return validatorText;
//             }
//           } else if (isPasswordField) {
//             if (estimatePasswordStrength(value!) <= 0.3 && value.isNotEmpty) {
//               return 'Password is too weak!';
//             } else if (value.isEmpty) {
//               return validatorText;
//             }
//           } else {
//             if (value == null || value.isEmpty) {
//               return validatorText;
//             }
//           }
//           return null;
//         },
//         onChanged: onChange,
//         style: GoogleFonts.workSans(
//           color: labelTextColor ?? Colors.black,
//           fontSize: 13.0,
//         ),
//         decoration: InputDecoration(
//           prefixIcon: prefixIcon != null
//               ? Icon(
//                   prefixIcon,
//                   color: Colors.black,
//                 )
//               : null,
//           labelText: labelText,
//           labelStyle: GoogleFonts.workSans(
//             color: labelTextColor ?? Colors.black,
//             fontSize: 13.0,
//           ),
//           hintText: hintText,
//           hintStyle: GoogleFonts.workSans(
//             color: hintTextColor ?? Colors.black38,
//             fontSize: 13.0,
//           ),
//           errorStyle: GoogleFonts.workSans(
//             fontSize: 13.0,
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(borderRadius ?? AppConst.radius),
//               borderSide: BorderSide(
//                 color: borderColor ?? Colors.white,
//               )),
//           errorBorder: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(borderRadius ?? AppConst.radius),
//               borderSide: BorderSide(
//                 color: borderColor ?? Colors.white,
//               )),
//           enabledBorder: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(borderRadius ?? AppConst.radius),
//               borderSide: BorderSide(
//                 color: borderColor ?? Colors.white,
//               )),
//           focusedBorder: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(borderRadius ?? AppConst.radius),
//               borderSide: BorderSide(
//                 color: borderColor ?? Colors.white,
//               )),
//         ),
//       ),
//     );
//   }
// }

Widget CustomTextField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? labelText,
  String? hintText,
  required IconData prefixIcon,
  FormFieldValidator<String>? validate,
  IconData? suffixIcon,
  void Function(String)? onSubmitted,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function()? suffixPressed,
  bool isPassword = false,
  double radius = 10.0,
}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          suffixIcon: suffixIcon != null
              ? IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixPressed,
          )
              : null,
        ),
        onChanged: onChanged,
        onTap: onTap,
        validator: validate,
        onFieldSubmitted: onSubmitted,
      ),
    );