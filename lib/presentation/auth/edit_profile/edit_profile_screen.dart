import 'package:flutter/material.dart';
import 'package:travinia/models/user_model.dart';
import 'package:travinia/presentation/auth/edit_profile/widgets/edit_profile_body.dart';

class EditProfile extends StatelessWidget {
  final UserModel userModel;

  const EditProfile({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EditProfileBody(/*userModel*/),
    );
  }
}
