import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/auth/register/widget/register_body.dart';
import 'package:travinia/presentation/shared_widgets/show_toast.dart';

import '../../../core/utils/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserRegisterSuccessState) {
          Navigator.pushReplacementNamed(context, Routes.main);
        }else if (state is UserRegisterErrorState) {
          showToast(message: state.error);
        }

      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: RegisterBody(
            cubit: cubit,
          ),
        );
      },
    );
  }
}
