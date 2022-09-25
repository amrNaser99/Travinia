import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/auth/login/widget/google_facebook_sign_in.dart';
import 'package:travinia/presentation/auth/login/widget/text_field_with_title.dart';
import 'package:travinia/presentation/home/home_screen.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';

import '../../../../core/utils/app_fonts.dart';
import '../../../shared_widgets/custom_text.dart';

class LoginBody extends StatelessWidget {
  final AuthCubit cubit;

  const LoginBody({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      LargeHeadText(text: "Login", size: FontSize.s24),
                    ],
                  ),
                  AppSpaces.vSpace20,
                  AppSpaces.vSpace10,
                  GoogleFacebookSignIn(),
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
                  TextFieldWithTitle(
                    controller: cubit.emailController,
                    title: "Email",
                    hint: "Enter first name",
                    inputType: TextInputType.emailAddress,
                  ),
                  AppSpaces.vSpace20,
                  TextFieldWithTitle(
                    controller: cubit.passwordController,
                    title: "Password",
                    hint: "Enter first name",
                    inputType: TextInputType.visiblePassword,
                  ),
                  AppSpaces.vSpace20,
                  Container(
                    padding:
                        EdgeInsetsDirectional.only(end: AppSize.s10, start: 0),
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
                  ConditionalBuilder(
                    condition: state is! UserLoginLoadingState,
                    builder: (context) => CustomButton(
                      fillColor: AppColors.appColor,
                      text: 'Login',
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (cubit.loginScaffoldKey.currentState!.validate()) {
                          cubit.userLogin(
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                          );
                        }
                      },
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
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
                          Navigator.pushReplacementNamed(context, '/register');
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
      },
    );
  }
}
