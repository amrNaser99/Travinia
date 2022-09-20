import 'package:flutter/material.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/models/create_booking_model.dart';
import 'package:travinia/models/facility_model.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/models/login_model.dart';
import 'package:travinia/models/profile_model.dart';
import 'package:travinia/models/register_model.dart';
import 'package:travinia/services/repositories/repository.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository repository;

  AppCubit({
    required this.repository,
  }) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  RegisterModel? registerModel;
  Color primaryColor = AppColors.primaryColor;
  Color secondaryColor = AppColors.secondaryColor;
  double colorOpacity = 1.0;
  ThemeData currentAppTheme = AppThemes.lightTheme;

  void changeAppThemeColor() {
    if (currentAppTheme == AppThemes.lightTheme) {
      primaryColor = AppColors.primaryDarkColor;
      secondaryColor = AppColors.secondaryDarkColor;
      currentAppTheme = AppThemes.darkTheme;
      colorOpacity = 0.2;
    } else {
      primaryColor = AppColors.primaryColor;
      secondaryColor = AppColors.secondaryColor;
      currentAppTheme = AppThemes.lightTheme;
      colorOpacity = 1.0;
    }
    emit(AppThemeColorChangedState());
  }

  void userRegister() async {
    emit(UserRegisterLoadingState());

    final response = await repository.register(
      name: 'medo mody',
      email: 'medo@gmail.com',
      password: '123456',
      password_confirmation: '123456',
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        registerModel = r;

        emit(UserRegisterSuccessState());
      },
    );
  }

  LoginModel? loginModel;

  void userLogin() async {
    emit(UserLoginLoadingState());

    final response = await repository.login(
      email: 'abdullah.mansour@gmail.com',
      password: '123456',
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        loginModel = r;

        emit(UserLoginSuccessState());
      },
    );
  }

  ProfileModel? profileModel;

  void userProfile() async {
    emit(UserProfileLoadingState());

    final response = await repository.getProfile(
      token: loginModel!.data!.token,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        profileModel = r;

        emit(UserProfileSuccessState());
      },
    );
  }

  List<HotelModel> hotels = [];

  void getHotels() async {
    emit(HotelsLoadingState());

    final response = await repository.getHotels(
      page: 1,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        hotels = r.data!.data;

        emit(HotelsSuccessState());
      },
    );
  }

  List<FacilityModel> facilities = [];

  void getFacilities() async {
    emit(FacilitiesLoadingState());

    final response = await repository.getFacilities();

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        facilities = r.facilities;
        debugPrint(facilities.toString());
        Future.delayed(Duration(seconds: 1));
        emit(FacilitiesSuccessState());
      },
    );
  }

  Create_BookingModel? create_BookingModel;

  void userCreate_Booking() async {
    emit(UserProfileLoadingState());

    final response = await repository.create_Booking(
      token: loginModel!.data!.token,
      user_id: loginModel!.data!.id,
      hotel_id: 10,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        create_BookingModel = r;

        emit(CreatBookingSuccessState());
      },
    );
  }
}
