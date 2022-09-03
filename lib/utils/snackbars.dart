import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar errorSnackBar(String message) {
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
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
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
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    snackPosition: SnackPosition.TOP,
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
