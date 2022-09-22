import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/user_model.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/auth/profile_info/widgets/profile_body.dart';

class ProfileInfoScreen extends StatelessWidget {
  final UserModel userModel;

  const ProfileInfoScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ProfileBody(
            userModel: userModel,
          ),
        );
      },
    );
  }
}
