import 'package:flutter/material.dart';
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
        child: Form(
          key: cubit.registerScaffoldKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: getBoldStyle(
                      fontColor: AppColors.white,
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
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.profileInfo);
                      },
                    ),
                  ),
                  AppSpaces.hSpace10,
                  Expanded(
                    child: CustomButton(
                      fillColor: AppColors.lightRed,
                      text: 'Google',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.editProfile);
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
              CustomTextField(
                textController: cubit.userNameController,
                hintText: 'Username',
                validatorText: 'Please Enter UserName Correctly',
                isEmailField: true,
              ),
              AppSpaces.vSpace20,
              CustomTextField(
                textController: cubit.emailController,
                hintText: 'Email',
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
                  cubit.registerScaffoldKey.currentState?.validate() ?? false
                      ? cubit.userRegister(
                          userName: cubit.userNameController.text,
                          email: cubit.emailController.text,
                          password: cubit.passwordController.text,
                          rePassword: cubit.verifyPasswordController.text,
                        )
                      : null;

                },
                fillColor: AppColors.appColor,
              ),
              AppSpaces.vSpace20,
              Text(
                'By signing up, you agree to our Terms of\n Service and Privacy Policy',

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
                    ),
                  ),
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
      ),
    );
  }
}
