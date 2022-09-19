import 'package:travinia/core/error/exceptions.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class UserLoginLoadingState extends AppStates {}

class UserLoginSuccessState extends AppStates {}

class UserRegisterLoadingState extends AppStates {}

class UserRegisterSuccessState extends AppStates {}

class UserProfileLoadingState extends AppStates {}

class UserProfileSuccessState extends AppStates {}

class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class FacilitiesLoadingState extends AppStates {}

class FacilitiesSuccessState extends AppStates {}

class CreatBookingSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}
