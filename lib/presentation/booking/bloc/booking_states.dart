import 'package:travinia/core/error/exceptions.dart';

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

class AllBookingsSuccess extends BookingState {}

class CompletedBookingsLoading extends BookingState {}

class CompletedBookingsSuccess extends BookingState {}

class UpcommingBookingsLoading extends BookingState {}

class UpcommingBookingsSuccess extends BookingState {}

class CancelledBookingsLoading extends BookingState {}

class CancelledBookingsSuccess extends BookingState {}
