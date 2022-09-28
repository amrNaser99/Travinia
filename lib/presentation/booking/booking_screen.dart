import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_fonts.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/presentation/booking/bloc/booking_cubit.dart';
import 'package:travinia/presentation/booking/bloc/booking_states.dart';
import 'package:travinia/presentation/booking/widgets/bookings_list.dart';
import 'package:travinia/presentation/booking/widgets/tab_bar_head.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';
import 'package:travinia/presentation/shared_widgets/show_toast.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller!.addListener(() {
      BookingCubit.get(context).changeTabBar(_controller!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is AllBookingsSuccess) {
          if (state.updateBookingModel != null) {
            showToast(
              message: state.updateBookingModel!.status!.title!.en!,
              textColor: AppColors.teal,
              backGroundColor: Theme.of(context).hintColor,
            );
          }
        }
      },
      builder: (context, state) {
        final BookingCubit cubit = BookingCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: LargeHeadText(
              text: "Bookings",
              size: FontSize.s20,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppWidth.w10),
            child: state is AllBookingsLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DefaultTabController(
                            length: cubit.bookings.length,
                            initialIndex: 0,
                            child: Column(children: [
                              SizedBox(height: AppHeight.h10),
                              TabBarHead(controller: _controller!),
                              BookingsList(
                                controller: _controller!,
                                state: state,
                              ),
                            ])),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
