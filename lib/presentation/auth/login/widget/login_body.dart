import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

class LoginBody extends StatelessWidget {
  final AuthCubit cubit;

  const LoginBody({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primaryDarkColor,
                  ),
                ),
              ],
            ),
            AppSpaces.vSpace20,
            AppSpaces.vSpace10,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    fillColor: Colors.indigo,
                    text: 'Facebook',
                    onPressed: () {},
                  ),
                ),
                AppSpaces.hSpace10,
                Expanded(
                  child: CustomButton(
                    fillColor: Colors.red[800],
                    text: 'Google',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            AppSpaces.vSpace20,
            Text(
              'or log with email',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontFamily: GoogleFonts.andika().fontFamily,
              ),
            ),
            AppSpaces.vSpace20,
            CustomTextField(
              textController: cubit.emailController,
              hintText: 'Email',
              isEmailField: true,
              validatorText: 'Please Enter E-mail Correctly',
            ),
            AppSpaces.vSpace20,
            CustomTextField(
              textController: cubit.passwordController,
              isPasswordField: true,
              hintText: 'Password',
              validatorText: 'Please Enter E-mail Correctly',
            ),
            AppSpaces.vSpace20,
            AppSpaces.vSpace10,
            AppSpaces.vSpace10,
            CustomButton(
              fillColor: AppColors.appColor,
              text: 'Login',
              onPressed: () {
                cubit.userLogin(
                  email: cubit.emailController.text,
                  password: cubit.passwordController.text,
                );
                cubit.emailController.clear();
                cubit.passwordController.clear();
              },
            ),
            AppSpaces.vSpace20,
            Text(
              'By signing up, you agree to our Terms of\n Service and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.lightGrey,
              ),
            ),
            AppSpaces.vSpace10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: TextStyle(
                      color: Colors.grey[600],
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text('Sign Up'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
