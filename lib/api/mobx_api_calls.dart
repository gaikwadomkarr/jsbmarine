import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/api/api_basic_call.dart';
import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/screens/authentication/login.dart';
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

  void uploadEntry(var data, int id, int selectedStatus) async {
    DataConstants.allEntriesControllerMobx.uploadEntryLoader = true;
    String url = insertSingleBill;
    try {
      var response = await ApiBasicCalls().getDio('json').post(url, data: data);
      log(response.requestOptions.baseUrl);
      if (response.statusCode == 200) {
        log(response.data.toString());
        await DataConstants.meterReadingControllerMobx
            .updateMeterReading(id, data);
        List<MeterReadingRecord> connections;
        if (selectedStatus == 0) {
          connections =
              await DataConstants.meterReadingControllerMobx.getConnections();
        } else {
          connections = await DataConstants.meterReadingControllerMobx
              .getAllMeterReadingsByMeterStatus(selectedStatus);
        }
        DataConstants.allEntriesControllerMobx
            .updateAllConnections(connections);
        DataConstants.allEntriesControllerMobx.uploadEntryLoader = false;
        Get.showSnackbar(successSnackBar(response.data['Message']));
      } else {
        DataConstants.allEntriesControllerMobx.uploadEntryLoader = false;
        Get.showSnackbar(errorSnackBar(response.data['error_description']));
      }
    } on DioError catch (e) {
      DataConstants.allEntriesControllerMobx.uploadEntryLoader = false;
      Get.showSnackbar(errorSnackBar(e.response!.data['Message']));
      if (e.response!.data.toString().contains('denied')) {
        Get.offAll(LoginScreen());
      }
    }
  }

  Future<bool> uploadBulkEntry(
      var data, List<MeterReadingRecord> meterRecords, int selectedStatus,
      {bool isReload = false}) async {
    if (isReload) {
      DataConstants.allEntriesControllerMobx.reloadEntryLoader = true;
    } else {
      DataConstants.allEntriesControllerMobx.uploadEntryLoader = true;
    }
    String url = insertBulkBill;
    try {
      var response = await ApiBasicCalls().getDio('json').post(url, data: data);
      log(response.requestOptions.baseUrl);
      if (response.statusCode == 200) {
        log("upload response =>" + jsonEncode(response.data));
        await DataConstants.meterReadingControllerMobx
            .updateBulkMeterReading(meterRecords);
        DataConstants.allEntriesControllerMobx.selectedConnections.clear();
        List<MeterReadingRecord> connections;
        if (selectedStatus == 0) {
          connections =
              await DataConstants.meterReadingControllerMobx.getConnections();
        } else {
          connections = await DataConstants.meterReadingControllerMobx
              .getAllMeterReadingsByMeterStatus(selectedStatus);
        }
        DataConstants.allEntriesControllerMobx
            .updateAllConnections(connections);
        if (isReload) {
          DataConstants.allEntriesControllerMobx.reloadEntryLoader = false;
        } else {
          DataConstants.allEntriesControllerMobx.uploadEntryLoader = false;
        }
        // Get.showSnackbar(successSnackBar("Record uploaded"));
        return true;
      } else {
        if (isReload) {
          DataConstants.allEntriesControllerMobx.reloadEntryLoader = false;
        } else {
          DataConstants.allEntriesControllerMobx.uploadEntryLoader = false;
        }
        Get.showSnackbar(errorSnackBar(response.data['error_description']));
        return false;
      }
    } on DioError catch (e) {
      if (isReload) {
        DataConstants.allEntriesControllerMobx.reloadEntryLoader = false;
      } else {
        DataConstants.allEntriesControllerMobx.uploadEntryLoader = false;
      }
      Get.showSnackbar(errorSnackBar(e.response!.data['Message']));
      if (e.response!.data.toString().contains('denied')) {
        Get.offAll(LoginScreen());
      }
      return false;
    }
  }

  void getBranchDetails() async {
    DataConstants.loginControllerMobx.showGetBranchLoader = true;
    String url = getBranch;
    try {
      var response = await ApiBasicCalls().getDio('json').post(url);
      log(response.requestOptions.baseUrl);
      if (response.statusCode == 200) {
        log(response.data.toString());
        DataConstants.loginControllerMobx.showGetBranchLoader = false;
        DataConstants.branchName = await DataConstants.loginControllerMobx
            .getBranchName(response.data as List);
      } else {
        DataConstants.loginControllerMobx.showGetBranchLoader = false;
        Get.showSnackbar(errorSnackBar(response.data['error_description']));
      }
    } on DioError catch (e) {
      DataConstants.loginControllerMobx.showGetBranchLoader = false;
      Get.showSnackbar(errorSnackBar(e.response!.data['Message']));
      if (e.response!.data.toString().contains('denied')) {
        Get.offAll(LoginScreen());
      }
    }
  }
}
