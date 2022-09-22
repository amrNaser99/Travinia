import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/presentation/hotel_details/hotel_details_cubit/hotel_details_states.dart';

class HotelDetailsCubit extends Cubit<HotelDetailsStates> {
  HotelDetailsCubit() : super(HotelDetailsInitState());

  static HotelDetailsCubit get(context) =>
      BlocProvider.of<HotelDetailsCubit>(context);

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
}
