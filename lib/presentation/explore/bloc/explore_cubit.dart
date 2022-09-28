import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/presentation/shared_widgets/show_toast.dart';
import 'package:travinia/services/repositories/repository.dart';

import '../../../models/hotel_model.dart';
import '../../auth/bloc/auth_cubit.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final Repository repository;

  ExploreCubit({required this.repository}) : super(ExploreInitial());

  static ExploreCubit get(context) => BlocProvider.of<ExploreCubit>(context);

  TextEditingController searchController = TextEditingController();

  //For Search hotels
  List<HotelModel> hotelResults = [];

  void searchHotels({
    required String text,
  }) async {
    emit(SearchHotelsLoadingState());
    final response = await repository.searchHotels(
      name: text,
    );
    response.fold((l) {

      searchController.clear();
      showToast(message: l.message);
      emit(ErrorState(exception: l));
    }, (r) {
      debugPrint('Search Results: ${r.data!.data}');
      debugPrint('Search Results: ${r.data!.data.length}');
      hotelResults = r.data!.data;
      emit(SearchHotelsSuccessState());
    });
  }

  //For Explore hotels
  ScrollController scrollController = ScrollController();
  double opacityValue = 1.0;

  void changeOpacityValue() {
    scrollController.addListener(() {
      setOpacityValue();
      emit(ChangeOpacityState());
    });
  }

  void setOpacityValue() {
    if (scrollController.offset > 100 && scrollController.offset < 400.0.h) {
      opacityValue = 1.0 - scrollController.offset / 1000;
    } else if (scrollController.offset < 100) {
      opacityValue = 1.0;
    } else {
      opacityValue = 0.0;
    }
  }

  void disposeScrollController() {
    scrollController.dispose();
  }

  //For Show Map or List

  bool isBMapClicked = false;

  void changeBMapClicked() {
    isBMapClicked = !isBMapClicked;
    debugPrint('isBMapClicked = $isBMapClicked');
    emit(ChangeBMapClickedState());
  }

  var calendarController = CrCalendarController();

  // create Data Range function
  void changeDateRange() {
     CrCalendar(
      controller: calendarController,

      initialDate: DateTime.now(),
    );
  }

  void createBooking(HotelModel hotel) async {
    emit(CreateBookingLoadingState());
    final response = await repository.create_Booking(
      token: loginModel!.data!.token!,
      user_id: loginModel!.data!.id!,
      hotel_id: hotel.id,
    );

    response.fold((l) => emit(CreateBookingErrorState()),
        (r) => emit(BookingCreatedSuccessState()));
  }

  //create dialog
  void createDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('Dialog'),
            content: Text('This is a dialog'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
}
