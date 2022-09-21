import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/login_model.dart';
import 'package:travinia/models/profile_model.dart';
import 'package:travinia/models/user_model.dart';
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
  var registerScaffoldKey = GlobalKey<FormState>();
  var loginScaffoldKey = GlobalKey<FormState>();

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


    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    verifyPasswordController.clear();

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        loginModel = r;

        emit(UserRegisterSuccessState());
      },
    );
  }

  UserModel? userModel;
  String? token;


  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(UserLoginLoadingState());

    final response = await repository.login(
      email: email,
      password: password,
    );

    emailController.clear();
    passwordController.clear();

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) async {
        loginModel = r;
        userModel = r.data;
        token = r.data?.token;
        debugPrint('token: ${token}');
        emit(UserLoginSuccessState(r.data!));
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
