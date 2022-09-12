import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

GetSnackBar errorSnackBar(String message) {
  Get.closeCurrentSnackbar();
  return GetSnackBar(
    mainButton: InkWell(
      onTap: () => Get.back(),
      child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          )),
    ),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 45.h),
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    animationDuration: const Duration(milliseconds: 300),
    forwardAnimationCurve: Curves.decelerate,
    borderRadius: 5,
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    backgroundColor: Colors.red,
    borderWidth: 0.5,
    borderColor: Colors.grey.shade700,
    duration: const Duration(seconds: 3),
  );
}

GetSnackBar successSnackBar(String message, {int duration = 1}) {
  Get.closeCurrentSnackbar();
  return GetSnackBar(
    mainButton: InkWell(
      onTap: () => Get.back(),
      child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.green),
          )),
    ),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 45.h),
    snackPosition: SnackPosition.BOTTOM,
    snackStyle: SnackStyle.FLOATING,
    forwardAnimationCurve: Curves.decelerate,
    borderRadius: 5,
    isDismissible: true,
    animationDuration: const Duration(milliseconds: 300),
    dismissDirection: DismissDirection.horizontal,
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.green),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    backgroundColor: Colors.white,
    borderWidth: 0.5,
    borderColor: Colors.grey.shade700,
    duration: const Duration(seconds: 3),
  );
}
