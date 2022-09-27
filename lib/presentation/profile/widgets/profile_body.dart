import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/font_styles.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/models/user_model.dart';
import 'package:travinia/presentation/explore/bloc/explore_cubit.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class ProfileBody extends StatelessWidget {
  final UserModel userModel;

  const ProfileBody({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
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
                      LargeHeadText(text: userModel.name!,size: AppSize.s20,),
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
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/user_image.png',
                            fit: BoxFit.cover,
                            // width: 80,
                            // height: 80,
                          ),
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
              ProfileItem(
                itemText: 'Permissions',
                icon: FontAwesomeIcons.personMilitaryPointing,
                onTap: () {
                  AppCubit.get(context).getBooking(
                    context: context,
                    bookType: BookingType.upcomming,
                    bookCount: 10,);
                },
              ),
              ProfileItem(
                itemText: 'change Password',
                icon: FontAwesomeIcons.lock,
                onTap: () {
                  Navigator.pushNamed(context, Routes.editProfile);
                },
              ),
              ProfileItem(
                itemText: 'Invite Friend',
                icon: FontAwesomeIcons.userGroup,
                onTap: () {
                  AppCubit.get(context).getHotels();
                },
              ),
              ProfileItem(
                itemText: 'Credit & Coupons',
                icon: FontAwesomeIcons.gift,
                onTap: () {
                  AppCubit.get(context).getHotels();
                },
              ),
              ProfileItem(
                itemText: 'Help Center',
                icon: FontAwesomeIcons.circleInfo,
                onTap: () {},
              ),
              ProfileItem(
                itemText: 'Payment',
                icon: FontAwesomeIcons.creditCard,
                onTap: () {},
              ),
              ProfileItem(
                itemText: 'Setting',
                icon: FontAwesomeIcons.gear,
                onTap: () {
                  cubit.changeAppThemeColor();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget ProfileItem({
  required String itemText,
  required IconData icon,
  required Function() onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Column(
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
                  child: LargeHeadText(text: itemText,),
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
      ),
    );
