import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travinia/presentation/explore/bloc/explore_hotel_state.dart';
import 'package:travinia/services/repositories/repository.dart';

class ExploreHotelCubit extends Cubit<ExploreHotelState> {
  final Repository repository;

  ExploreHotelCubit({required this.repository}) : super(ExploreHotelInitial());

  TextEditingController searchController = TextEditingController();
}
