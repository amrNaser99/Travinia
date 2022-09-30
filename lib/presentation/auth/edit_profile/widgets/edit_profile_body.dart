import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_contstants.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/models/user_model.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_spaces.dart';

class EditProfileBody extends StatelessWidget {
  final UserModel userModel;
  const EditProfileBody({
    Key? key,
    required this.userModel,
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
              LargeHeadText(
                text: 'Edit Profile',
                size: AppSize.s20,
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
                        radius: AppWidth.w55,
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
          ProfileInfoItem(itemText: 'UserName', Data: userModel.name!),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Email', Data: userModel.email!),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Phone', Data: '+65113684411'),
          AppSpaces.vSpace20,
          ProfileInfoItem(itemText: 'Date of Birth', Data: '15, Aug , 1999'),
          AppSpaces.vSpace20,
          ProfileInfoItem(
              itemText: 'Address', Data: '23 Royal Street, LiverPool'),
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
                child: PrimaryText(
                  text: itemText,
                  size: AppSize.s15,
                ),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: LargeHeadText(
                    text: Data,
                    size: AppSize.s15,
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
