import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/edit_profile/edit_profile_screen.dart';
import 'package:travinia/presentation/auth/login/login_screen.dart';
import 'package:travinia/presentation/auth/register/register_screen.dart';
import 'package:travinia/presentation/explore/explore_hotels/explore_hotel_screen.dart';
import 'package:travinia/presentation/explore/hotel_details/hotel_details_screen.dart';
import 'package:travinia/presentation/main/main_screen.dart';
import 'package:travinia/presentation/onboarding/on_boarding_screen.dart';
import 'package:travinia/presentation/splash/splash_screen.dart';

import '../../presentation/explore/explore_hotels/filter/filter_screen.dart';
import '../../presentation/explore/explore_on_map/explore_map_screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String main = '/main';
  static const String onBoarding = '/onBoarding';
  static const String hotelDetailsScreen = '/hotelDetailsScreen';
  static const String register = '/register';
  static const String login = '/login';
  static const String exploreHotels = '/exploreHotels';
  static const String exploreOnMap = '/exploreOnMap';
  static const String editProfile = '/edit_profile';
  static const String filter = '/filter';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => SplashScreen(),
      onBoarding: (context) => OnBoardingScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      main: (context) => const MainScreen(),
      exploreHotels: (context) => const ExploreHotelScreen(),
      exploreOnMap: (context) => ExploreOnMap(),
      hotelDetailsScreen: (context) => const HotelDetailsScreen(),
      filter: (context) => Filter(),
      editProfile: (context) => EditProfile(
            userModel: BlocProvider.of<AuthCubit>(context).userModel!,
          ),
    };
  }
}
