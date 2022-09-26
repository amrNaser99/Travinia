import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/services/repositories/repository.dart';

import '../../../models/hotel_model.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final Repository repository;

  ExploreCubit({required this.repository}) : super(ExploreInitial());

  static ExploreCubit get(context) => BlocProvider.of<ExploreCubit>(context);

  TextEditingController searchController = TextEditingController();

  //For Search hotels
  List<HotelModel> hotelResults = [];

  void searchHotels() async {
    emit(SearchHotelsLoadingState());
    final response = await repository.searchHotels(name: searchController.text);

    response.fold((l) {
      emit(ErrorState(exception: l));
    }, (r) {
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
