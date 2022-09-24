import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/test/widgets/app_bar/home_app_bar.dart';
import 'package:travinia/presentation/test/widgets/body/best_deals_head.dart';
import 'package:travinia/presentation/test/widgets/body/hotel_card_info.dart';
import 'package:travinia/presentation/test/widgets/bottom_nav_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    AppCubit.get(context).getHotels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          body: state is HotelsLoadingState
              ? Center(child: CircularProgressIndicator())
              : state is ErrorState
                  ? Center(child: Text("ERROR"))
                  : state is HotelsLoadingState
                      ? CircularProgressIndicator()
                      : state is ErrorState
                          ? Text("ERROR")
                          : CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                HomeAppBar(),
                                SliverToBoxAdapter(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppWidth.w10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: AppHeight.h20),
                                          BestDealsHead(),
                                          ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: cubit.hotels.length,
                                            separatorBuilder: (context,
                                                    index) =>
                                                SizedBox(height: AppHeight.h20),
                                            itemBuilder: (context, index) =>
                                                HotelCardInfo(
                                                    hotel: cubit.hotels[index]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
          bottomNavigationBar: AppBottomNavigationBar(),
        );
      },
    );
  }
}
