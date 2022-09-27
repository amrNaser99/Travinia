import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/presentation/booking/bloc/booking_cubit.dart';
import 'package:travinia/presentation/shared_widgets/custom_text.dart';

class PopUpInfo {
  final String text;
  final IconData icon;
  final Color color;

  PopUpInfo({required this.text, required this.icon, required this.color});
}

class BookingPopupMenu extends StatelessWidget {
  const BookingPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookingCubit cubit = BookingCubit.get(context);

    List<PopUpInfo> items = cubit.popUpList[cubit.tabBarIndex];
    print(cubit.tabBarIndex);
    return PopupMenuButton(
        icon: Icon(Icons.more_horiz_outlined, color: AppColors.white),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).scaffoldBackgroundColor,
            )),
        //color: !cubit.isDarkMode?const Color(0xff010108):Colors.white,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        enabled: true,
        onSelected: (PopUpInfo value) {
          debugPrint(value.toString());
          //cubit.deletePost(index: index);
        },
        itemBuilder: (context) {
          return items.map((PopUpInfo choice) {
            return PopupMenuItem(
              value: choice,
              child: Row(
                children: [
                  Expanded(child: SmallHeadText(text: choice.text)),
                  Icon(
                    choice.icon,
                    color: choice.color,
                  )
                ],
              ),
            );
          }).toList();
        });
  }
}
