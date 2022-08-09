import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/api/api_basic_call.dart';
import 'package:jsbmarineversion1/screens/main_screen.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/save_local_storage.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';

class MobxApiCalls {
  Future<void> loginApiCall(var data) async {
    DataConstants.loginControllerMobx.showLoginLoader = true;
    String url = singInUrl;
    try {
      var response = await ApiBasicCalls()
          .getDioWithoutToken('json')
          .post(url, data: data);
      log(response.requestOptions.baseUrl);
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        DataConstants.loginControllerMobx.updateLoginDetails(response.data);
        DataConstants.loginControllerMobx.showLoginLoader = false;
        var userMap = {
          "ContactNo": data["UserName"],
          "Password": data["Password"],
          "IMENumber": ""
        };
        log(userMap.toString());
        checkLoggedInUser(userMap);
        Preferences.saveUserLoggedIn(true);
        Preferences.saveToken(
            DataConstants.loginControllerMobx.loginDetails.accessToken!);
        TOKEN = DataConstants.loginControllerMobx.loginDetails.accessToken!;
        Get.showSnackbar(successSnackBar('Logged in successfully'));
        Get.off(MainScreen());
      } else {
        DataConstants.loginControllerMobx.showLoginLoader = false;
        Get.showSnackbar(errorSnackBar(response.data['error_description']));
      }
    } on DioError catch (e) {
      DataConstants.loginControllerMobx.showLoginLoader = false;
      if (e.response != null) {
        Get.showSnackbar(errorSnackBar(e.response!.data['error_description']));
      } else {
        Get.showSnackbar(
            errorSnackBar("Server is down, please try again later!"));
      }
    }
  }

  Future<void> checkLoggedInUser(var data) async {
    // DataConstants.loginControllerMobx.showLoginLoader = true;
    String url = checkTabUser;
    try {
      var response = await ApiBasicCalls()
          .getDioWithoutToken('json')
          .post(url, data: data);
      log(response.requestOptions.baseUrl);
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        if (response.data["Message"] != null) {
          DataConstants.loginControllerMobx.updateUserDetails(response.data);
          // DataConstants.loginControllerMobx.showLoginLoader = false;
          Preferences.saveUserId(
              DataConstants.loginControllerMobx.userDetails.userID!);
          Preferences.saveUserName(
              DataConstants.loginControllerMobx.userDetails.name!);
          Preferences.saveBranchID(
              DataConstants.loginControllerMobx.userDetails.branchID!);
          DataConstants.username =
              DataConstants.loginControllerMobx.userDetails.name!;
          DataConstants.userID =
              DataConstants.loginControllerMobx.userDetails.userID!;
          DataConstants.branchID =
              DataConstants.loginControllerMobx.userDetails.branchID!;
          debugPrint(await Preferences.getUserId());
          debugPrint(await Preferences.getUserName());
          debugPrint(await Preferences.getBranchID());
        }
      } else {
        // DataConstants.loginControllerMobx.showLoginLoader = false;
        Get.showSnackbar(errorSnackBar(response.data['error_description']));
      }
    } on DioError catch (e) {
      // DataConstants.loginControllerMobx.showLoginLoader = false;
      Get.showSnackbar(errorSnackBar(e.response!.data['message']));
    }
  }
}
