import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/presentation/explore/hotel_details/cubit/hotel_details_page_states.dart';

class HotelDetailsPageCubit extends Cubit<HotelDetailsPageStates> {
  HotelDetailsPageCubit() : super(HotelDetailsPageInitState());

  static HotelDetailsPageCubit get(context) =>
      BlocProvider.of<HotelDetailsPageCubit>(context);
  ScrollController scrollController = ScrollController();
  double opacityValue = 1.0;

  void changeOpacityValue() {
    opacityValue = 1.0;
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
}
