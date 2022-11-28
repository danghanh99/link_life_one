import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static show(
    BuildContext context, {
    required String message,
    Color? backGround,
    TextStyle? textStyle,
    Widget? icon,
  }) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: backGround ?? Colors.red,
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: textStyle ?? TextStyle(color: Colors.white, fontSize: 18.sp),
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }
}
