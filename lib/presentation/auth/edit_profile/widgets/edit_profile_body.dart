import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/models/user_model.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_spaces.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({
    Key? key,
    // required UserModel userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppWidth.w20,
        vertical: AppWidth.w10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Edit Profile',
                style: getBoldStyle(
                  fontColor: AppColors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          AppSpaces.vSpace20,
          AppSpaces.vSpace10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: AppConst.shadow,
                ),
                child: Container(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: AppWidth.w54,
                        backgroundColor: AppColors.white,
                        child: CircleAvatar(
                          radius: AppWidth.w53,
                          backgroundImage: AssetImage(
                            'assets/images/user_image.png',
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: 0,
                        end: AppSize.s8,
                        child: CircleAvatar(
                          radius: AppWidth.w15,
                          child: Icon(
                            FontAwesomeIcons.cameraRetro,
                            size: AppSize.s17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'UserName', Data: 'Amr Naser El-Sayed'),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Email', Data: 'AmrNaserr1@gmail.com'),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Phone', Data: '+65113684411'),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Date of Birth', Data: '15, Aug , 1999'),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Address', Data: '23 Royal Street, LiverPool'),

        ],
      ),
    );
  }
}

Widget ProfileInfoItem({
  required String itemText,
  required String Data,
}) =>
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
                child: Text(
                  itemText,
                  style: getMediumStyle(
                    fontColor: AppColors.grey,
                    fontSize: AppSize.s15,
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  textAlign: TextAlign.end,
                  Data,
                  style: getSemiBoldStyle(
                    fontColor: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[800]!.withOpacity(0.6),
        ),
      ],
    );
