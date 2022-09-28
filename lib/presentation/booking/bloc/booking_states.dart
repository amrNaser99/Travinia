import 'package:travinia/core/error/exceptions.dart';
import 'package:travinia/models/status_model.dart';
import 'package:travinia/models/update_booking_model/update_booking_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class ErrorState extends BookingState {
  // final PrimaryServerException exception;

  // ErrorState({
  //   required this.exception,
  // });
}

class ChangeTabBar extends BookingState {}

class AllBookingsLoading extends BookingState {}

class AllBookingsSuccess extends BookingState {
  UpdateBookingModel? updateBookingModel;

  AllBookingsSuccess({this.updateBookingModel});
}

class CompletedBookingsLoading extends BookingState {}

class CompletedBookingsSuccess extends BookingState {}

class UpcommingBookingsLoading extends BookingState {}

class UpcommingBookingsSuccess extends BookingState {}

class CancelledBookingsLoading extends BookingState {}

class CancelledBookingsSuccess extends BookingState {}

class UpdateBookingsLoading extends BookingState {}

class UpdateBookingsSuccess extends BookingState {}
