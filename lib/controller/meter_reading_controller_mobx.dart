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
  @observable
  bool showSubmitToDBLoader = false;

  @action
  void setshowSubmitToDBLoader(bool status) {
    showSubmitToDBLoader = status;
  }

  @action
  Future<bool> saveMeterReading(MeterReadingRecord meterReadingDb) async {
    showSubmitToDBLoader = true;
    var client = meterReadingDB;
    int success = 0;
    await client!
        .insert('MeterReadings', meterReadingDb.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      showSubmitToDBLoader = false;
      log('insert status $value');
      success = value;
    }).catchError((onError) {
      showSubmitToDBLoader = false;
      log(onError.toString());
    }).onError((error, stackTrace) {
      showSubmitToDBLoader = false;
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
  Future<bool> recordExist(String consumerNumber) async {
    showSubmitToDBLoader = true;
    var isExist = false;
    var client = meterReadingDB;

    var records = await client!.rawQuery(
        "SELECT * FROM MeterReadings WHERE barcode='$consumerNumber'");
    if (records.isNotEmpty) {
      isExist = true;
    }

    showSubmitToDBLoader = false;
    return isExist;
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
  Future<bool> deleteMultipleMeterReading(int meterStatus) async {
    var client = meterReadingDB;
    int success = 0;
    int count = 0;
    for (var element
        in DataConstants.allEntriesControllerMobx.selectedConnections) {
      await client!.delete("MeterReadings",
          where: "id = ?", whereArgs: [element.id]).then((value) {
        log('delete status $value');
        count++;
      }).catchError((onError) {
        log(onError.toString());
      }).onError((error, stackTrace) {
        Get.showSnackbar(errorSnackBar(error.toString()));
      });
    }

    if (count ==
        DataConstants.allEntriesControllerMobx.selectedConnections.length) {
      success = 1;
    }

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
  Future<bool> recordExists(MeterReadingRecord meterReadingRecord) async {
    final client = meterReadingDB;
    var exists = false;
    await client!.query("MeterReadings",
        where: "id= ?", whereArgs: [meterReadingRecord.id]).then((value) {
      if (value.isNotEmpty) {
        exists = true;
      }
    });
    return exists;
  }

  @action
  Future<List<MeterReadingRecord>> getConnections() async {
    DataConstants.allEntriesControllerMobx.selectedConnectionsLoader = true;
    DataConstants.allEntriesControllerMobx.allConnectionsLoader = true;
    final client = meterReadingDB;
    final List<Map<String, dynamic>> connectionList = await client!.query(
        'MeterReadings',
        where: "branchID =?",
        whereArgs: [DataConstants.branchID]);
    debugPrint(connectionList.toString());
    DataConstants.allEntriesControllerMobx.selectedConnectionsLoader = false;
    DataConstants.allEntriesControllerMobx.allConnectionsLoader = false;
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
    final List<Map<String, dynamic>> connectionList = await client!.rawQuery(
        "SELECT * from MeterReadings WHERE uploadStatus='$status' and branchID='${DataConstants.branchID}'");
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
        "SELECT * from MeterReadings WHERE meterStatus='$meterStatus' and branchID='${DataConstants.branchID}'");
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
  Future<List<MeterReadingRecord>> getLimitedMeterReadingsByStatus(
      status) async {
    final client = meterReadingDB;
    final List<Map<String, dynamic>> connectionList = await client!.rawQuery(
        "SELECT * from MeterReadings WHERE uploadStatus='$status' and branchID='${DataConstants.branchID}' LIMIT 100");
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
  //       '''UPDATE MeterReadings SET uploadStatus = "Yes" Where id IN (Select id from MeterReadings Where uploadStatus = "No" Limit 100)''');
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

  @action
  Future<bool> updateBulkMeterReading(
      List<MeterReadingRecord> meterRecords) async {
    var client = meterReadingDB;
    int success = 0;
    int count = 0;
    for (var element in meterRecords) {
      client!
          .update('MeterReadings', {"uploadStatus": "Yes"},
              where: "id= ?", whereArgs: [element.id])
          .then((value) {
        count++;
      });
    }

    print("upload status updated $count");

    if (count == meterRecords.length) {
      success = 1;
    }
    if (success >= 1) {
      return true;
    } else {
      return false;
    }
  }
}
