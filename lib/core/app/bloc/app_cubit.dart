import 'package:flutter/cupertino.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/facility_model.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/models/login_model.dart';
import 'package:travinia/models/profile_model.dart';
import 'package:travinia/services/repositories/repository.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository repository;

  AppCubit({
    required this.repository,
  }) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

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
}
