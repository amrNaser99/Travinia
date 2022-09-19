import 'package:travinia/core/error/exceptions.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class FacilitiesLoadingState extends AppStates {}

class FacilitiesSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}

class GetBookingLoadingState extends AppStates {}

class GetBookingSuccessState extends AppStates {}
