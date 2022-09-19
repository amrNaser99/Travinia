import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/login_model.dart';
import 'package:travinia/models/profile_model.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';
import 'package:travinia/services/repositories/repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository repository;

  AuthCubit({required this.repository}) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  LoginModel? loginModel;

  void userRegister() async {
    emit(UserRegisterLoadingState());

    final response = await repository.register(
      userName: 'amr_naser',
      email: 'amrnaserr1@gmail.com',
      password: '123456',
      rePassword: '123456',
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        debugPrint('r: $r');
        loginModel = r;

        emit(UserLoginSuccessState());
      },
    );
  }

  void userLogin() async {
    emit(UserLoginLoadingState());

    final response = await repository.login(
      email: 'amrnaserr1@gmail.com',
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
}
