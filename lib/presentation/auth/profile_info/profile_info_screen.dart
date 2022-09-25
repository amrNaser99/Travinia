import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/user_model.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/presentation/auth/profile_info/widgets/profile_body.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        // final userModel =
        //     ModalRoute.of(context)!.settings.arguments as UserModel;
        UserModel? userModel = AuthCubit.get(context).userModel;
        return  Scaffold(
          appBar: AppBar(leading: Text(''),),
          body: ConditionalBuilder(
            condition: state != UserLoginLoadingState() &&
                userModel != null,
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
        );
      },
    );
  }
}
