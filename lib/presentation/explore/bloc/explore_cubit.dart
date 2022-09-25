import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travinia/presentation/explore/bloc/explore_state.dart';
import 'package:travinia/services/repositories/repository.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final Repository repository;

  ExploreCubit({required this.repository}) : super(ExploreInitial());

  static ExploreCubit get(context) => BlocProvider.of<ExploreCubit>(context);
  TextEditingController searchController = TextEditingController();


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
