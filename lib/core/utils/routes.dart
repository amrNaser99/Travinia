import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/presentation/auth/login/login_screen.dart';
import 'package:travinia/presentation/auth/register/register_screen.dart';
import 'package:travinia/presentation/explore/hotel_details/hotel_details_screen.dart';
import 'package:travinia/presentation/test/test_screen.dart';

import '../../presentation/auth/bloc/auth_cubit.dart';
import '../../presentation/auth/edit_profile/edit_profile_screen.dart';
import '../../presentation/auth/profile_info/profile_info_screen.dart';
import '../../presentation/explore/explore_hotels/explore_hotel_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/onboarding/on_boarding_screen.dart';

class Routes {
  static const String home = '/home';
  static const String onBoarding = '/onBoarding';
  static const String hotelDetailsScreen = '/hotelDetailsScreen';
  static const String register = '/register';
  static const String login = '/login';
  static const String exploreHotels = '/exploreHotels';
  // static const String profileInfo = '/profile';
  static const String editProfile = '/edit_profile';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const TestScreen(),
      onBoarding: (context) => OnBoardingScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      exploreHotels: (context) => const ExploreHotelScreen(),
      hotelDetailsScreen: (context) => const HotelDetailsScreen(),
      // profileInfo: (context) => ProfileInfoScreen(),
      editProfile: (context) => EditProfile(
            userModel: BlocProvider.of<AuthCubit>(context).userModel!,
          ),
    };
  }
}
