import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/models/profile_model.dart';
import 'package:travinia/models/user_model.dart';

class ProfileBody extends StatelessWidget {
  final UserModel userModel;

  const ProfileBody({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.editProfile,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.s20,
              vertical: AppSize.s10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Amanda',
                        userModel.name!,
                        style: getBoldStyle(
                          fontColor: AppColors.white,
                          fontSize: 25,
                        ),
                      ),
                      AppSpaces.vSpace5,
                      Text(
                        'View and Edit Profile',
                        style: getSemiBoldStyle(
                          fontColor: AppColors.secondGrey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage('${userModel.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSpaces.vSpace10,
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.s20,
            vertical: AppSize.s10,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.editProfile);
                },
                child: ProfileItem(
                  itemText: 'change Password',
                  icon: FontAwesomeIcons.lock,
                ),
              ),
              ProfileItem(
                itemText: 'Invite Friend',
                icon: FontAwesomeIcons.userGroup,
              ),
              ProfileItem(
                itemText: 'Invite Friend',
                icon: FontAwesomeIcons.userGroup,
              ),
              ProfileItem(
                itemText: 'Invite Friend',
                icon: FontAwesomeIcons.userGroup,
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget ProfileItem({required String itemText, required IconData icon}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: AppWidth.w20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  itemText,
                  style: getMediumStyle(
                    fontColor: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.secondGrey,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.secondGrey,
        ),
      ],
    );
