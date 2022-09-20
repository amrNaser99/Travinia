import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';
import 'package:travinia/presentation/shared_widgets/custom_text_field.dart';

class RegisterBody extends StatelessWidget {
  final AuthCubit cubit;

  const RegisterBody({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(AppSize.s20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sign up',
                  style: getBoldStyle(
                    fontColor: Colors.white,
                    fontSize: AppSize.s30,
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
                    fillColor: AppColors.darkBlue,
                    text: 'Facebook',
                    onPressed: () {},
                  ),
                ),
                AppSpaces.hSpace10,
                Expanded(
                  child: CustomButton(
                    fillColor: AppColors.lightRed,
                    text: 'Google',
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.profileInfo);
                    },
                  ),
                ),
              ],
            ),
            AppSpaces.vSpace20,
            Text(
              'or log with email',
              style: getRegularStyle(
                fontColor: AppColors.secondGrey,
                fontSize: AppSize.s15,
              ),
            ),
            AppSpaces.vSpace20,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppHeight.h5,
              ),
              child: Text(
                'UserName',
                style: getSemiBoldStyle(
                  fontColor: AppColors.grey,
                ),
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
            CustomTextField(
              textController: cubit.userNameController,
              hintText: 'Enter Your UserName',
              validatorText: 'Please Enter UserName Correctly',
              isEmailField: true,
              maxlength: 1,
            ),
            AppSpaces.vSpace10,
            CustomTextField(
              textController: cubit.emailController,
              hintText: 'Enter Your E-Mail',
              isEmailField: true,
              validatorText: 'Please Enter E-Mail Correctly',
            ),
            AppSpaces.vSpace20,
            CustomTextField(
              textController: cubit.passwordController,
              isPasswordField: true,
              hintText: 'Password',
              validatorText: 're-Enter Password',
              obscureText: true,

            ),
            AppSpaces.vSpace20,
            CustomTextField(
              textController: cubit.verifyPasswordController,
              isPasswordField: true,
              hintText: 'Verify Password',
              validatorText: 're-Enter Password',
              obscureText: true,
            ),
            AppSpaces.vSpace20,
            AppSpaces.vSpace10,
            CustomButton(
              text: 'Sign up',
              onPressed: () {
                cubit.userRegister(
                  userName: cubit.userNameController.text.trim(),
                  email: cubit.emailController.text.trim(),
                  password: cubit.passwordController.text.trim(),
                  rePassword: cubit.verifyPasswordController.text.trim(),
                );
                cubit.userNameController.clear();
                cubit.emailController.clear();
                cubit.passwordController.clear();
                cubit.verifyPasswordController.clear();
              },
              fillColor: AppColors.appColor,
            ),
            AppSpaces.vSpace20,
            Text(
              'By signing up, you agree to our Terms of\n Service and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
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
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Login'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
