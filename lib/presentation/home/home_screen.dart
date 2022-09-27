import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/home/widgets/app_bar/app_bar.dart';
import 'package:travinia/presentation/home/widgets/body/best_deals_head.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_card_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  ValueNotifier<bool> _textVisibilty = ValueNotifier<bool>(true);

  void _checkTextVisibilty(notification) {
    if (notification is ScrollUpdateNotification) {
      /*
        490 refers to total pixels 320 expandedHeight +
        150 collapsedHeight + 20 sizedbox
      */
      if (_scrollController.position.pixels >=
          MediaQuery.of(context).size.height - AppHeight.h490) {
        _textVisibilty.value = false;
      } else {
        _textVisibilty.value = true;
      }
    }
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
    AppCubit.get(context).getMyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (state is HotelsLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(child: Text("ERROR"));
        } else {
          return ValueListenableBuilder(
            valueListenable: _textVisibilty,
            builder: (BuildContext context, value, Widget? child) {
              return NotificationListener(
                onNotification: (notification) {
                  _checkTextVisibilty(notification);
                  return true;
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    HomeAppBar(
                      textAndButtonVisibilty: _textVisibilty.value,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppWidth.w10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppHeight.h20),
                            BestDealsHead(),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.hotels.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: AppHeight.h20),
                              itemBuilder: (context, index) =>
                                  HotelCardInfo(hotel: cubit.hotels[index]),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
