import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_spaces.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/home/widgets/hotel_data_widget.dart';

class buildHotelsImage extends StatelessWidget {
  final List<HotelModel> hotelData;

  const buildHotelsImage({Key? key, required this.hotelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => HotelDataWidget(
                hotelName: hotelData[index].name,
                hotelAdress: hotelData[index].address,
                distance: 2.0,
                hotelRating: hotelData[index].rate,
                hotelPrice: hotelData[index].price,
              ),
              separatorBuilder: (context, index) => AppSpaces.vSpace10,
              itemCount: hotelData.length,
            ),
          ),
        );
      },
    );
  }
}
