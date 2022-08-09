import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class WaterConnectionDBHelper {
  static final WaterConnectionDBHelper instance =
      WaterConnectionDBHelper._internal();
  static Database? meterReadingDB;
  WaterConnectionDBHelper._internal();

  factory WaterConnectionDBHelper() {
    return instance;
  }

  Future<Database> get meterreadingDb async {
    if (DataConstants.meterReadingControllerMobx.meterReadingDB != null) {
      return DataConstants.meterReadingControllerMobx.meterReadingDB!;
    }
    DataConstants.meterReadingControllerMobx.meterReadingDB =
        await meterReadingDbinit();
    return DataConstants.meterReadingControllerMobx.meterReadingDB!;
  }

  Future<Database> meterReadingDbinit() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      log("Cannot get download folder path");
    }
    String meterReadingDbPath =
        join("${directory!.path}/MeterReading/", 'MeterReading.db');
    print("this is db path => " + meterReadingDbPath.toString());
    var database = openDatabase(
      meterReadingDbPath,
      version: 2,
      onCreate: _onCreateMeter,
    );

    return database;
  }

  void _onCreateMeter(Database db, int version) {
    db.execute('''
      CREATE TABLE meterreadings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userID TEXT,
        branchID TEXT,
        deviceId TEXT,
        barcode TEXT,
        miterNumber INTEGER,
        meterReading INTEGER,
        meterStatus TEXT,
        latitude TEXT,
        longitude TEXT,
        locationName TEXT,
        scanDate TEXT,
        imageBase64 TEXT,
        meterImage TEXT,
        uploadStatus TEXT
        )
    ''');
    debugPrint("Database was created!");
  }

  // Future<List<MeterReadingRecord>> getMeterReadingsList() async {
  //   final client = await meterreadingDb;
  //   final List<Map<String, dynamic>> connectionList =
  //       await client.query('meterreadings');
  //   return List.generate(connectionList.length, (i) {
  //     return MeterReadingRecord(
  //         id: connectionList[i]['id'],
  //         consumerName: connectionList[i]['consumerName'],
  //         consumerPhoto: connectionList[i]['consumerPhoto'],
  //         meterNumber: connectionList[i]['meterNumber'],
  //         meterReading: connectionList[i]['meterReading'],
  //         consumerAddress: connectionList[i]['consumerAddress'],
  //         latitude: connectionList[i]['latitude'],
  //         longitude: connectionList[i]['longitude'],
  //         createdAt: connectionList[i]['created_at'],
  //         branchId: connectionList[i]['branchId'],
  //         uploadStatus: connectionList[i]["uploadStatus"]);
  //   });
  // }

  // Future<List<MeterReadingRecord>> geMeterReadingsByName(name) async {
  //   final client = await meterreadingDb;
  //   final List<Map<String, dynamic>> connectionList = await client.rawQuery(
  //       "SELECT * from meterreadings WHERE consumerName like '%$name%'");
  //   return List.generate(connectionList.length, (i) {
  //     return MeterReadingRecord(
  //         id: connectionList[i]['id'],
  //         consumerName: connectionList[i]['consumerName'],
  //         consumerPhoto: connectionList[i]['consumerPhoto'],
  //         meterNumber: connectionList[i]['meterNumber'],
  //         meterReading: connectionList[i]['meterReading'],
  //         consumerAddress: connectionList[i]['consumerAddress'],
  //         latitude: connectionList[i]['latitude'],
  //         longitude: connectionList[i]['longitude'],
  //         createdAt: connectionList[i]['created_at'],
  //         branchId: connectionList[i]['branchId'],
  //         uploadStatus: connectionList[i]["uploadStatus"]);
  //   });
  // }

  // Future<List<MeterReadingRecord>> getMeterReadingsByStatus(status) async {
  //   final client = await meterreadingDb;
  //   final List<Map<String, dynamic>> connectionList = await client.rawQuery(
  //       "SELECT * from meterreadings WHERE uploadStatus='$status' LIMIT 25");
  //   return List.generate(connectionList.length, (i) {
  //     return MeterReadingRecord(
  //         id: connectionList[i]['id'],
  //         consumerName: connectionList[i]['consumerName'],
  //         consumerPhoto: connectionList[i]['consumerPhoto'],
  //         meterNumber: connectionList[i]['meterNumber'],
  //         meterReading: connectionList[i]['meterReading'],
  //         consumerAddress: connectionList[i]['consumerAddress'],
  //         latitude: connectionList[i]['latitude'],
  //         longitude: connectionList[i]['longitude'],
  //         createdAt: connectionList[i]['created_at'],
  //         branchId: connectionList[i]['branchId'],
  //         uploadStatus: connectionList[i]["uploadStatus"]);
  //   });
  // }

  // Future<List<MeterReadingRecord>> getAllMeterReadingsByStatus(status) async {
  //   final client = await meterreadingDb;
  //   final List<Map<String, dynamic>> connectionList = await client
  //       .rawQuery("SELECT * from meterreadings WHERE uploadStatus='$status'");
  //   return List.generate(connectionList.length, (i) {
  //     return MeterReadingRecord(
  //         id: connectionList[i]['id'],
  //         consumerName: connectionList[i]['consumerName'],
  //         consumerPhoto: connectionList[i]['consumerPhoto'],
  //         meterNumber: connectionList[i]['meterNumber'],
  //         meterReading: connectionList[i]['meterReading'],
  //         consumerAddress: connectionList[i]['consumerAddress'],
  //         latitude: connectionList[i]['latitude'],
  //         longitude: connectionList[i]['longitude'],
  //         createdAt: connectionList[i]['created_at'],
  //         branchId: connectionList[i]['branchId'],
  //         uploadStatus: connectionList[i]["uploadStatus"]);
  //   });
  // }

  // Future<List<MeterReadingRecord>> getMeterReadingsByDate(
  //     startDate, endDate) async {
  //   final client = await meterreadingDb;
  //   List<Map<String, dynamic>> connectionList = List<Map<String, dynamic>>();
  //   connectionList = await client.rawQuery(
  //       "SELECT * from meterreadings WHERE created_at BETWEEN '$startDate' AND '$endDate'");
  //   return List.generate(connectionList.length, (i) {
  //     return MeterReadingRecord(
  //         id: connectionList[i]['id'],
  //         consumerName: connectionList[i]['consumerName'],
  //         consumerPhoto: connectionList[i]['consumerPhoto'],
  //         meterNumber: connectionList[i]['meterNumber'],
  //         meterReading: connectionList[i]['meterReading'],
  //         consumerAddress: connectionList[i]['consumerAddress'],
  //         latitude: connectionList[i]['latitude'],
  //         longitude: connectionList[i]['longitude'],
  //         createdAt: connectionList[i]['created_at'],
  //         branchId: connectionList[i]['branchId'],
  //         uploadStatus: connectionList[i]["uploadStatus"]);
  //   });
  // }
}
