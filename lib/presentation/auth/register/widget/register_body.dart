import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/auth/login/widget/google_facebook_sign_in.dart';
import 'package:travinia/presentation/auth/login/widget/text_field_with_title.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

import '../../../shared_widgets/custom_button.dart';

class RegisterBody extends StatelessWidget {
  final AuthCubit cubit;

  const RegisterBody({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsetsDirectional.only(
                start: AppConst.mainPadding,
                end: AppConst.mainPadding,
                bottom: AppConst.mainPadding),
            child: Form(
              key: cubit.registerScaffoldKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: LargeHeadText(text: "Sign up", size: FontSize.s24),
                  ),
                  SizedBox(height: AppHeight.h30),
                  GoogleFacebookSignIn(),
                  SizedBox(height: AppHeight.h10),
                  SecondaryText(text: 'or log with email'),
                  SizedBox(height: AppHeight.h20),
                  TextFieldWithTitle(
                    controller: cubit.firstNameController,
                    title: "First name",
                    hint: "Enter first name",
                    inputType: TextInputType.text,
                    validateText: 'First Name Error! ..Please Try Again',


                  ),
                  SizedBox(height: AppHeight.h20),
                  TextFieldWithTitle(
                    controller: cubit.lastNameController,
                    title: "Last name",
                    hint: "Enter last name",
                    inputType: TextInputType.text,
                    validateText: 'Last Name Error! ..Please Try Again',
                  ),
                  SizedBox(height: AppHeight.h20),
                  TextFieldWithTitle(
                    controller: cubit.emailController,
                    title: "Your email",
                    hint: "Enter your email",
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: AppHeight.h20),
                  TextFieldWithTitle(
                    controller: cubit.passwordController,
                    title: "Password",
                    hint: "Enter password",
                    inputType: TextInputType.text,
                    obscure: true,
                    validateText: 'Password Error! ..Re-Enter Try Again',
                  ),
                  SizedBox(height: AppHeight.h20),
                  ConditionalBuilder(
                      condition: state is! UserRegisterLoadingState,
                      builder: (context) => CustomButton(
                        fillColor: AppColors.appColor,
                        text: 'Sign up',
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (cubit.registerScaffoldKey.currentState!
                              .validate()) {
                            cubit.userRegister(
                              firstName: cubit.firstNameController.text,
                              lastName: cubit.lastNameController.text,
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text,
                              rePassword: cubit.verifyPasswordController.text,
                            );
                          }
                        },
                      ),
                      fallback:(context) => Center(
                        child: CircularProgressIndicator(),
                      ),

                  ),
                  SizedBox(height: AppHeight.h20),
                  SecondaryText(
                    text:
                    'By signing up, you agree to our Terms of\n Service and Privacy Policy',
                    isLight: true,
                    center: true,
                    size: FontSize.s13,
                  ),
                  SizedBox(height: AppHeight.h10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SecondaryText(
                        text: 'Already have an account? log in',
                        center: true,
                        size: FontSize.s13,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: TealText(
                          text: 'Login',
                        ),
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
