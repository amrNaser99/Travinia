import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travinia/core/utils/app_spaces.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      'Amanda',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'view and Edit Profile',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 26,
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
                      radius: 25,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/app_logo_light.png'),
                        // image: NetworkImage('url'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpaces.vSpace20,
          AppSpaces.vSpace20,
          ProfileItem(
            itemText: 'change Password',
            icon: FontAwesomeIcons.solidEnvelope,
          ),
          ProfileItem(
            itemText: 'Invite Friend',
            icon: FontAwesomeIcons.userGroup,
          ),
        ],
      ),
    );
  }
}

Widget ProfileItem({required String itemText, required IconData icon}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            Icon(
              icon,
              size: 20,
            ),
          ],
        ),
        AppSpaces.vSpace10,
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
      ],
    );
