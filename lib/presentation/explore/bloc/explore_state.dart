import 'package:travinia/models/hotel_model.dart';

import '../../../core/error/exceptions.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ChangeOpacityState extends ExploreState {}

class ChangeBMapClickedState extends ExploreState {}

class SearchHotelsLoadingState extends ExploreState {}

class SearchHotelsSuccessState extends ExploreState {
  final List<HotelModel> hotelResults;

  SearchHotelsSuccessState({required this.hotelResults});
}

class BookingCreatedSuccessState extends ExploreState {}

class CreateBookingLoadingState extends ExploreState {}

class ChangeHotelsOrSearchWidgetsState extends ExploreState {}

class CreateBookingErrorState extends ExploreState {}

class ErrorState extends ExploreState {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}
