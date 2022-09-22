import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/auth/login/widget/google_facebook_sign_in.dart';
import 'package:travinia/presentation/auth/login/widget/text_field_with_title.dart';
import 'package:travinia/presentation/shared_widgets/custom_button.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class LoginBody extends StatelessWidget {
  final AuthCubit cubit;

  const LoginBody({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is UserLoginSuccessState) {
        Navigator.pushNamed(context, '/home');
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(AppSize.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: LargeHeadText(text: "Login", size: FontSize.s30)),
              AppSpaces.vSpace20,
              AppSpaces.vSpace10,
              GoogleFacebookSignIn(),
              AppSpaces.vSpace20,
              SecondaryText(text: 'or log with email'),
              AppSpaces.vSpace20,
              TextFieldWithTitle(
                controller: cubit.emailController,
                title: "Your email",
                hint: "enter your email",
                inputType: TextInputType.emailAddress,
              ),
              AppSpaces.vSpace20,
              TextFieldWithTitle(
                controller: cubit.passwordController,
                title: "Password",
                hint: "enter your password",
                inputType: TextInputType.text,
                obscure: true,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: SecondaryText(
                    text: "Forgot your password?",
                    isButton: true,
                    size: FontSize.s12,
                    isLight: true,
                  ),
                ),
              ),
              AppSpaces.vSpace10,
              CustomButton(
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
            ],
          ),
        ),
      );
    });
  }
}
