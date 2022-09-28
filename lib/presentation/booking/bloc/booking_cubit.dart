import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/booking_model.dart';
import 'package:travinia/models/booking_screen_info.dart';
import 'package:travinia/models/status_model.dart';
import 'package:travinia/models/update_booking_model/update_booking_model.dart';
import 'package:travinia/presentation/booking/bloc/booking_states.dart';
import 'package:travinia/presentation/booking/widgets/pop_up_menu.dart';
import 'package:travinia/presentation/main/dio_test.dart';
import 'package:travinia/services/repositories/repository.dart';

class BookingCubit extends Cubit<BookingState> {
  final Repository repository;

  BookingCubit({required this.repository}) : super(BookingInitial());

  static BookingCubit get(context) => BlocProvider.of<BookingCubit>(context);

  List<BookingScreenInfo> bookings = [
    BookingScreenInfo(
      title: "Completed",
      bookingList: [],
      loadingList: [],
    ),
    BookingScreenInfo(
      title: "Upcomming",
      bookingList: [],
      loadingList: [],
    ),
    BookingScreenInfo(
      title: "Cancelled",
      bookingList: [],
      loadingList: [],
    ),
  ];
  // TabController? controller;
  List<List<PopUpInfo>> popUpList = [
    [
      PopUpInfo(
        text: "Upcoming",
        icon: Icons.upcoming,
        color: Colors.amber,
      ),
      PopUpInfo(
        text: "Cancelled",
        icon: Icons.cancel_outlined,
        color: Colors.red,
      ),
    ],
    [
      PopUpInfo(
        text: "Completed",
        icon: Icons.done_all_outlined,
        color: Colors.green,
      ),
      PopUpInfo(
        text: "Cancelled",
        icon: Icons.cancel_outlined,
        color: Colors.red,
      ),
    ],
    [
      PopUpInfo(
        text: "Completed",
        icon: Icons.done_all_outlined,
        color: Colors.green,
      ),
      PopUpInfo(
        text: "Upcoming",
        icon: Icons.upcoming,
        color: Colors.amber,
      ),
    ],
  ];

  final String token =
      "lDskjVorwaBlDmi1uW2LUJKRBU4DRFZxmTtCGv4hnAfnivtCZeiszUxeyIaK";

  int tabBarIndex = 0;
  void changeTabBar(int index) {
    tabBarIndex = index;
    // if (index == 0) {}
    emit(ChangeTabBar());
  }

  void updateBooking({
    required int booking_id,
    required String type,
    required int index,
  }) async {
    emit(UpdateBookingsLoading());
    bookings[tabBarIndex].loadingList.add(index);
    final response = await repository.updateBooking(
      booking_id: booking_id,
      type: type,
    );

    response.fold(
      (exception) {
        bookings[tabBarIndex].loadingList.remove(index);
        emit(ErrorState());
      },
      (updateBookingModel) {
        bookings[tabBarIndex].loadingList.remove(index);
        getAllBookings(isUpdate: true, updateBookingModel: updateBookingModel);
        // print("UPDATED =====> ${statusModel.}");
        // emit(UpdateBookingsSuccess());
      },
    );
  }

  void getCompletedBookings() {
    emit(CompletedBookingsLoading());
    DioTest.getBooking(type: 'completed').then((value) {
      BookingModel bookingModel = BookingModel.fromJson(value.data);
      bookings[0].bookingList = bookingModel.Data!.data!;
      print("DONE ===> ${value}");
      emit(CompletedBookingsSuccess());
    }).catchError((error) {
      print("ERROR");
      emit(ErrorState());
    });
  }

  void getUpcommingBookings({UpdateBookingModel? updateBookingModel}) {
    DioTest.getBooking(type: 'upcomming').then((value) {
      BookingModel bookingModel = BookingModel.fromJson(value.data);
      bookings[1].bookingList = bookingModel.Data!.data!;
      getCancelledBookings(updateBookingModel: updateBookingModel);
    }).catchError((error) {
      print("ERROR IN GET UPCOMMING");
      emit(ErrorState());
    });
  }

  void getCancelledBookings({UpdateBookingModel? updateBookingModel}) {
    DioTest.getBooking(type: "cancelled").then((value) {
      BookingModel bookingModel = BookingModel.fromJson(value.data);
      bookings[2].bookingList = bookingModel.Data!.data!;
      print("DONE ===> ${value}");
      emit(AllBookingsSuccess(updateBookingModel: updateBookingModel));
    }).catchError((error) {
      print("ERROR IN GET CANCELLED");
      emit(ErrorState());
    });
  }

  void getAllBookings(
      {bool? isUpdate, UpdateBookingModel? updateBookingModel}) {
    if (isUpdate != true) {
      emit(AllBookingsLoading());
    }
    DioTest.getBooking(type: 'completed').then((value) {
      BookingModel bookingModel = BookingModel.fromJson(value.data);
      bookings[0].bookingList = bookingModel.Data!.data!;
      getUpcommingBookings(updateBookingModel: updateBookingModel);
    }).catchError((error) {
      print("ERROR IN GET COMPLETED");
      emit(ErrorState());
    });
  }
}
