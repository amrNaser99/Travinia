import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
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
        child: Form(
          key: cubit.loginScaffoldKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: getBoldStyle(
                      fontColor: AppColors.white,
                      fontSize: 30,
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
                      onPressed: () {

                      },
                    ),
                  ),
                  AppSpaces.hSpace10,
                  Expanded(
                    child: CustomButton(
                      fillColor: AppColors.lightRed,
                      text: 'Google',
                      onPressed: () {},
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
              AppSpaces.vSpace10,
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
              Container(
                padding: EdgeInsetsDirectional.only(end: AppSize.s10, start: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: getLightStyle(
                        fontColor: AppColors.appColor,
                        fontSize: AppSize.s12,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpaces.vSpace10,
              CustomButton(
                fillColor: AppColors.appColor,
                text: 'Login',
                onPressed: () {
                  cubit.loginScaffoldKey.currentState!.validate()
                      ? cubit.userLogin(
                          email: cubit.emailController.text,
                          password: cubit.passwordController.text,
                        )
                      : null;
                },
              ),
              AppSpaces.vSpace20,
              Text(
                'By signing up, you agree to our Terms of\n Service and Privacy Policy',
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  fontColor: AppColors.secondGrey,
                  fontSize: AppSize.s13,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: getRegularStyle(
                      fontColor: AppColors.secondGrey,
                      fontSize: AppSize.s13,
                    ),
                  ),
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
      ),
    );
  }
}
