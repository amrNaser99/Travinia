import 'package:travinia/core/error/exceptions.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppThemeColorChangedState extends AppStates {}

class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class FacilitiesLoadingState extends AppStates {}

class FacilitiesSuccessState extends AppStates {}

class CreateBookingLoadingState extends AppStates {}

class CreateBookingSuccessState extends AppStates {}

class GetBookingLoadingState extends AppStates {}

class GetBookingSuccessState extends AppStates {}

class GetLocationLoadingState extends AppStates {}

class GetLocationSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}

class changeNavBarState extends AppStates {}
