import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
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
  bool saveMeterReading(MeterReadingRecord meterReadingDb) {
    var client = meterReadingDB;
    int success = 0;
    client!
        .insert('MeterReadings', meterReadingDb.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {});

    if (success == 1) {
      print("reading entry made to database");
      return true;
    } else {
      return false;
    }
  }

  @action
  bool deleteMeterReading(int id) {
    var client = meterReadingDB;
    int success = 0;
    client!.delete("MeterReadings", where: "id = ?", whereArgs: [id]).then(
        (value) {
      success = value;
    });
    if (success >= 1) {
      print("entry made to database");
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
    return List.generate(connectionList.length, (i) {
      return MeterReadingRecord(
        id: connectionList[i]['id'],
        deviceId: connectionList[i]['deviceId'],
        scanDate: connectionList[i]['scanDate'],
        meterReading: connectionList[i]['meterReading'],
        barcode: int.parse(connectionList[i]['barcode']),
        miterNumber: connectionList[i]['miterNumber'],
        userID: connectionList[i]['userID'],
        branchID: connectionList[i]['branchID'],
        locationName: connectionList[i]['locationName'],
        imageBase64: connectionList[i]['imageBase64'],
        meterStatus: connectionList[i]['meterStatus'],
        uploadStatus: connectionList[i]['uploadStatus'],
        latitude: connectionList[i]['latitude'],
        longitude: connectionList[i]['longitude'],
      );
    });
  }

  // @action
  // Future<void> updateLimitMeterReading() {
  //   var client = meterReadingDB;
  //   client!.rawUpdate(
  //       '''UPDATE MeterReadings SET uploadStatus = "Yes" Where id IN (Select id from MeterReadings Where uploadStatus = "No" Limit 25)''');
  //   print("entry made to database");
  // }

  // @action
  // Future<void> updateMeterReading() {
  //   var client = meterReadingDB;
  //   client!.rawUpdate(
  //       '''UPDATE MeterReadings SET uploadStatus = "Yes" WHERE uploadStatus = "No"''');
  //   print("entry made to database");
  // }
}
