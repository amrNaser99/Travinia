import 'package:travinia/core/error/exceptions.dart';
import 'package:travinia/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}


class UserLoginLoadingState extends AuthState {}

class UserLoginSuccessState extends AuthState {
  final UserModel userModel;

  UserLoginSuccessState(this.userModel);
}
class UserLoginErrorState extends AuthState {
  final String error;

  UserLoginErrorState(this.error);
}

class UserRegisterLoadingState extends AuthState {}

class UserRegisterSuccessState extends AuthState {}
class UserRegisterErrorState extends AuthState {
  final String error;

  UserRegisterErrorState(this.error);
}


class UserProfileLoadingState extends AuthState {}

class UserProfileSuccessState extends AuthState {}


class ErrorState extends AuthState {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}

class AuthPasswordVisibilityState extends AuthState {}





