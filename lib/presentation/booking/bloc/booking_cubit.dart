import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/models/booking_screen_info.dart';
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
    ),
    BookingScreenInfo(
      title: "Upcomming",
      bookingList: [],
    ),
    BookingScreenInfo(
      title: "Cancelled",
      bookingList: [],
    ),
  ];
  // TabController? controller;
  List<List<PopUpInfo>> popUpList = [
    [
      PopUpInfo(
        text: "Upcomming",
        icon: Icons.alarm,
        color: Colors.green,
      ),
      PopUpInfo(
        text: "Cancel",
        icon: Icons.library_add,
        color: Colors.pink,
      ),
    ],
    [
      PopUpInfo(
        text: "Completed",
        icon: Icons.alarm,
        color: Colors.green,
      ),
      PopUpInfo(
        text: "Cancel",
        icon: Icons.library_add,
        color: Colors.pink,
      ),
    ],
    [
      PopUpInfo(
        text: "Completed",
        icon: Icons.alarm,
        color: Colors.green,
      ),
      PopUpInfo(
        text: "Upcomming",
        icon: Icons.library_add,
        color: Colors.pink,
      ),
    ],
  ];

  final String token =
      "lDskjVorwaBlDmi1uW2LUJKRBU4DRFZxmTtCGv4hnAfnivtCZeiszUxeyIaK";

  int tabBarIndex = 0;
  void changeTabBar(int index) {
    tabBarIndex = index;
    emit(ChangeTabBar());
  }

  void getCompletedBookings() {
    emit(CompletedBookingsLoading());
    DioTest.getBooking().then((value) {
      print("DONE ===> ${value}");
      emit(CompletedBookingsSuccess());
    }).catchError((error) {
      print("ERROR");
      emit(ErrorState());
    });

    // final response = await repository.getBooking(
    //   bookType: "completed",
    //   token: token,
    //   bookCount: 10,
    // );
    // response.fold(
    //   (l) => emit(ErrorState()),
    //   (r) {
    //     bookings[0].bookingList = r.Data!.data!;
    //     emit(CompletedBookingsSuccess());
    //   },
    // );
  }

  void createBooking() async {
    final response = await repository.create_Booking(
      token: token,
      user_id: 300,
      hotel_id: 9,
    );

    response.fold(
      (l) => emit(ErrorState()),
      (r) {
        print("DONE ===> ${r.status.messageEn}");
        // bookings[0].bookingList = r.Data!.data!;
        emit(CompletedBookingsSuccess());
      },
    );
  }

  void getUpcommingBookings() async {
    emit(UpcommingBookingsLoading());
    final response = await repository.getBooking(
      bookType: "upcomming",
      token: token,
    );

    response.fold(
      (l) {
        print("ERROR IN getUpcommingBookings");
        emit(ErrorState());
      },
      (r) {
        print("DONE");
        bookings[1].bookingList = r.Data!.data!;
        emit(UpcommingBookingsSuccess());
      },
    );
  }

  void getCancelledBookings() async {
    emit(CancelledBookingsLoading());
    final response = await repository.getBooking(
      bookType: "cancelled",
      token: token,
    );

    response.fold(
      (l) {
        print("ERROR IN getUpcommingBookings");
        emit(ErrorState());
      },
      (r) {
        print("DONE");
        bookings[2].bookingList = r.Data!.data!;
        emit(CancelledBookingsSuccess());
      },
    );
  }
}
