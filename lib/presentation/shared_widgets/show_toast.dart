import 'package:fluttertoast/fluttertoast.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_values.dart';

void showToast({
  required String message,
  bool isShort = false,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      textColor: AppColors.white,
      fontSize: AppSize.s16,);
}
