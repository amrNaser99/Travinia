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

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var verifyPasswordController = TextEditingController();
  var isPassword = true;
  var isVerifyPassword = true;
  var formKey = GlobalKey<FormState>();

  void checkPassword() {
    isPassword = !isPassword;
    emit(AuthPasswordVisibilityState());
  }

  void checkPasswordVerification() {
    isVerifyPassword = !isVerifyPassword;
    emit(AuthPasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userRegister({
    required String userName,
    required String email,
    required String password,
    required String rePassword,
  }) async {
    emit(UserRegisterLoadingState());

    final response = await repository.register(
      userName: userName,
      email: email,
      password: password,
      rePassword: rePassword,
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

  void userLogin({
    required String email,
    required String password,

  }) async {
    emit(UserLoginLoadingState());

    final response = await repository.login(
      email: email,
      password: password,
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

    final response = await repository.getProfileInfo(
      token: loginModel!.data!.token!,
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
