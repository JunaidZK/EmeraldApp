import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void showToast(
  String message,
) {
  Fluttertoast.showToast(
    msg: message,
    textColor: whiteColor,
    fontSize: 16.sp,
    backgroundColor: primaryColor,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}
