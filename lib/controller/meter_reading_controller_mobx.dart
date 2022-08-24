import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'meter_reading_controller_mobx.g.dart';

class MeterReadingController = _MeterReadingControllerBase
    with _$MeterReadingController;

abstract class _MeterReadingControllerBase with Store {
  @observable
  MeterReadingRecord meterReadingRecord = MeterReadingRecord();
  @observable
  Database? meterReadingDB;

  @action
  Future<bool> saveMeterReading(MeterReadingRecord meterReadingDb) async {
    var client = meterReadingDB;
    int success = 0;
    await client!
        .insert('MeterReadings', meterReadingDb.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      log('insert status $value');
      success = value;
    }).catchError((onError) {
      log(onError.toString());
    }).onError((error, stackTrace) {
      Get.showSnackbar(errorSnackBar(error.toString()));
    });

    if (success >= 1) {
      print("reading entry made to database");
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<bool> deleteMeterReading(int id, int meterStatus) async {
    var client = meterReadingDB;
    int success = 0;
    await client!.delete("MeterReadings",
        where: "id = ?", whereArgs: [id]).then((value) {
      log('delete status $value');
      success = value;
    }).catchError((onError) {
      log(onError.toString());
    }).onError((error, stackTrace) {
      Get.showSnackbar(errorSnackBar(error.toString()));
    });
    if (success == 1) {
      log("entry made to database");
      if (meterStatus == 0) {
        DataConstants.allEntriesControllerMobx.allconnections =
            await getConnections();
      } else {
        DataConstants.allEntriesControllerMobx.allconnections =
            await getAllMeterReadingsByMeterStatus(meterStatus);
      }
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<List<MeterReadingRecord>> getConnections() async {
    final client = meterReadingDB;
    final List<Map<String, dynamic>> connectionList =
        await client!.query('MeterReadings');
    debugPrint(connectionList.toString());
    return List.generate(connectionList.length, (i) {
      return MeterReadingRecord(
        id: connectionList[i]['id'],
        deviceId: connectionList[i]['deviceId'],
        scanDate: connectionList[i]['scanDate'],
        meterReading: connectionList[i]['meterReading'],
        barcode: connectionList[i]['barcode'],
        miterNumber: connectionList[i]['miterNumber'].toString(),
        userID: connectionList[i]['userID'],
        branchID: connectionList[i]['branchID'],
        locationName: connectionList[i]['locationName'],
        imageBase64: connectionList[i]['imageBase64'],
        meterImage: connectionList[i]['meterImage'],
        meterStatus: connectionList[i]['meterStatus'],
        uploadStatus: connectionList[i]['uploadStatus'],
        latitude: connectionList[i]['latitude'],
        longitude: connectionList[i]['longitude'],
      );
    });
  }

  @action
  Future<List<MeterReadingRecord>> getAllMeterReadingsByStatus(status) async {
    final client = meterReadingDB;
    final List<Map<String, dynamic>> connectionList = await client!
        .rawQuery("SELECT * from MeterReadings WHERE uploadStatus='$status'");
    return List.generate(connectionList.length, (i) {
      return MeterReadingRecord(
        id: connectionList[i]['id'],
        deviceId: connectionList[i]['deviceId'],
        scanDate: connectionList[i]['scanDate'],
        meterReading: connectionList[i]['meterReading'],
        barcode: connectionList[i]['barcode'],
        miterNumber: connectionList[i]['miterNumber'].toString(),
        userID: connectionList[i]['userID'],
        branchID: connectionList[i]['branchID'],
        locationName: connectionList[i]['locationName'],
        imageBase64: connectionList[i]['imageBase64'],
        meterImage: connectionList[i]['meterImage'],
        meterStatus: connectionList[i]['meterStatus'],
        uploadStatus: connectionList[i]['uploadStatus'],
        latitude: connectionList[i]['latitude'],
        longitude: connectionList[i]['longitude'],
      );
    });
  }

  @action
  Future<List<MeterReadingRecord>> getAllMeterReadingsByMeterStatus(
      int meterStatus) async {
    final client = meterReadingDB;
    final List<Map<String, dynamic>> connectionList = await client!.rawQuery(
        "SELECT * from MeterReadings WHERE meterStatus='$meterStatus'");
    log(connectionList.toString());
    return List.generate(connectionList.length, (i) {
      return MeterReadingRecord(
        id: connectionList[i]['id'],
        deviceId: connectionList[i]['deviceId'],
        scanDate: connectionList[i]['scanDate'],
        meterReading: connectionList[i]['meterReading'],
        barcode: connectionList[i]['barcode'],
        miterNumber: connectionList[i]['miterNumber'].toString(),
        userID: connectionList[i]['userID'],
        branchID: connectionList[i]['branchID'],
        locationName: connectionList[i]['locationName'],
        imageBase64: connectionList[i]['imageBase64'],
        meterImage: connectionList[i]['meterImage'],
        meterStatus: connectionList[i]['meterStatus'],
        uploadStatus: connectionList[i]['uploadStatus'],
        latitude: connectionList[i]['latitude'],
        longitude: connectionList[i]['longitude'],
      );
    });
  }

  @action
  Future<String> deleteMeterRecord(
      MeterReadingRecord meterReadingRecord) async {
    final client = meterReadingDB;
    String response = '';
    await client!.delete('MeterReadings',
        where: 'id = ?', whereArgs: [meterReadingRecord.id]).then((value) {
      log('this is delete value $value');
      if (value == 1) {
        response = 'success';
      } else {
        response = 'fail';
      }
    }).onError((error, stackTrace) {
      response = 'error';
    });

    return response;
  }

  // @action
  // Future<void> updateLimitMeterReading() {
  //   var client = meterReadingDB;
  //   client!.rawUpdate(
  //       '''UPDATE MeterReadings SET uploadStatus = "Yes" Where id IN (Select id from MeterReadings Where uploadStatus = "No" Limit 25)''');
  //   print("entry made to database");
  // }

  @action
  Future<bool> updateMeterReading(int id, Map<String, dynamic> data) async {
    var client = meterReadingDB;
    int success = 0;
    client!
        .update('MeterReadings', {"uploadStatus": "Yes"},
            where: "id= ?", whereArgs: [id])
        .then((value) {
      success = value;
    });
    print("upload status updated");

    if (success == 1) {
      return true;
    } else {
      return false;
    }
  }
}
