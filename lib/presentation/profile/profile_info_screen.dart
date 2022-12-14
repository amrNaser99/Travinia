import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/user_model.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/profile/widgets/profile_body.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        // final userModel =
        //     ModalRoute.of(context)!.settings.arguments as UserModel;
        UserModel? userModel = AuthCubit.get(context).userModel;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: state != UserLoginLoadingState() && userModel != null,
                  builder: (BuildContext context) {
                    return ProfileBody(
                      userModel: userModel!,
                    );
                  },
                  fallback: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
