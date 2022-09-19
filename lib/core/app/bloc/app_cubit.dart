import 'package:flutter/cupertino.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/booking_model.dart';
import 'package:travinia/models/facility_model.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/services/repositories/repository.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository repository;

  AppCubit({
    required this.repository,
  }) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  List<HotelModel> hotels = [];

  void getHotels() async {
    emit(HotelsLoadingState());

    final response = await repository.getHotels(
      page: 1,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        hotels = r.data!.data;

        emit(HotelsSuccessState());
      },
    );
  }

  List<FacilityModel> facilities = [];

  void getFacilities() async {
    emit(FacilitiesLoadingState());

    final response = await repository.getFacilities();

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        facilities = r.facilities;
        debugPrint(facilities.toString());
        Future.delayed(Duration(seconds: 1));
        emit(FacilitiesSuccessState());
      },
    );
  }

  BookingModel? bookingModel;

  Future<void> getBooking({required BuildContext context}) async {
    emit(GetBookingLoadingState());
    final response = await repository.getBooking(
      token: BlocProvider.of<AuthCubit>(context).loginModel!.data!.token,
      bookType: 'completed',
      bookCount: 10,
    );

    response.fold((l) {
      emit(ErrorState(exception: l));
    }, (r) {
      debugPrint('r : $r');
      // bookingModel = r;
      emit(GetBookingSuccessState());
    });
  }
}
