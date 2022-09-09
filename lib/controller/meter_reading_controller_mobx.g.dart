// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_reading_controller_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MeterReadingController on _MeterReadingControllerBase, Store {
  late final _$meterReadingRecordAtom = Atom(
      name: '_MeterReadingControllerBase.meterReadingRecord', context: context);

  @override
  MeterReadingRecord get meterReadingRecord {
    _$meterReadingRecordAtom.reportRead();
    return super.meterReadingRecord;
  }

  @override
  set meterReadingRecord(MeterReadingRecord value) {
    _$meterReadingRecordAtom.reportWrite(value, super.meterReadingRecord, () {
      super.meterReadingRecord = value;
    });
  }

  late final _$meterReadingDBAtom = Atom(
      name: '_MeterReadingControllerBase.meterReadingDB', context: context);

  @override
  Database? get meterReadingDB {
    _$meterReadingDBAtom.reportRead();
    return super.meterReadingDB;
  }

  @override
  set meterReadingDB(Database? value) {
    _$meterReadingDBAtom.reportWrite(value, super.meterReadingDB, () {
      super.meterReadingDB = value;
    });
  }

  late final _$showSubmitToDBLoaderAtom = Atom(
      name: '_MeterReadingControllerBase.showSubmitToDBLoader',
      context: context);

  @override
  bool get showSubmitToDBLoader {
    _$showSubmitToDBLoaderAtom.reportRead();
    return super.showSubmitToDBLoader;
  }

  @override
  set showSubmitToDBLoader(bool value) {
    _$showSubmitToDBLoaderAtom.reportWrite(value, super.showSubmitToDBLoader,
        () {
      super.showSubmitToDBLoader = value;
    });
  }

  late final _$saveMeterReadingAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.saveMeterReading',
      context: context);

  @override
  Future<bool> saveMeterReading(MeterReadingRecord meterReadingDb) {
    return _$saveMeterReadingAsyncAction
        .run(() => super.saveMeterReading(meterReadingDb));
  }

  late final _$recordExistAsyncAction =
      AsyncAction('_MeterReadingControllerBase.recordExist', context: context);

  @override
  Future<bool> recordExist(String consumerNumber) {
    return _$recordExistAsyncAction
        .run(() => super.recordExist(consumerNumber));
  }

  late final _$deleteMeterReadingAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.deleteMeterReading',
      context: context);

  @override
  Future<bool> deleteMeterReading(int id, int meterStatus) {
    return _$deleteMeterReadingAsyncAction
        .run(() => super.deleteMeterReading(id, meterStatus));
  }

  late final _$deleteMultipleMeterReadingAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.deleteMultipleMeterReading',
      context: context);

  @override
  Future<bool> deleteMultipleMeterReading(int meterStatus) {
    return _$deleteMultipleMeterReadingAsyncAction
        .run(() => super.deleteMultipleMeterReading(meterStatus));
  }

  late final _$recordExistsAsyncAction =
      AsyncAction('_MeterReadingControllerBase.recordExists', context: context);

  @override
  Future<bool> recordExists(MeterReadingRecord meterReadingRecord) {
    return _$recordExistsAsyncAction
        .run(() => super.recordExists(meterReadingRecord));
  }

  late final _$getConnectionsAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.getConnections',
      context: context);

  @override
  Future<List<MeterReadingRecord>> getConnections() {
    return _$getConnectionsAsyncAction.run(() => super.getConnections());
  }

  late final _$getAllMeterReadingsByStatusAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.getAllMeterReadingsByStatus',
      context: context);

  @override
  Future<List<MeterReadingRecord>> getAllMeterReadingsByStatus(dynamic status) {
    return _$getAllMeterReadingsByStatusAsyncAction
        .run(() => super.getAllMeterReadingsByStatus(status));
  }

  late final _$getAllMeterReadingsByMeterStatusAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.getAllMeterReadingsByMeterStatus',
      context: context);

  @override
  Future<List<MeterReadingRecord>> getAllMeterReadingsByMeterStatus(
      int meterStatus) {
    return _$getAllMeterReadingsByMeterStatusAsyncAction
        .run(() => super.getAllMeterReadingsByMeterStatus(meterStatus));
  }

  late final _$getLimitedMeterReadingsByStatusAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.getLimitedMeterReadingsByStatus',
      context: context);

  @override
  Future<List<MeterReadingRecord>> getLimitedMeterReadingsByStatus(
      dynamic status) {
    return _$getLimitedMeterReadingsByStatusAsyncAction
        .run(() => super.getLimitedMeterReadingsByStatus(status));
  }

  late final _$deleteMeterRecordAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.deleteMeterRecord',
      context: context);

  @override
  Future<String> deleteMeterRecord(MeterReadingRecord meterReadingRecord) {
    return _$deleteMeterRecordAsyncAction
        .run(() => super.deleteMeterRecord(meterReadingRecord));
  }

  late final _$updateMeterReadingAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.updateMeterReading',
      context: context);

  @override
  Future<bool> updateMeterReading(int id, Map<String, dynamic> data) {
    return _$updateMeterReadingAsyncAction
        .run(() => super.updateMeterReading(id, data));
  }

  late final _$updateBulkMeterReadingAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.updateBulkMeterReading',
      context: context);

  @override
  Future<bool> updateBulkMeterReading(List<MeterReadingRecord> meterRecords) {
    return _$updateBulkMeterReadingAsyncAction
        .run(() => super.updateBulkMeterReading(meterRecords));
  }

  late final _$_MeterReadingControllerBaseActionController =
      ActionController(name: '_MeterReadingControllerBase', context: context);

  @override
  void setshowSubmitToDBLoader(bool status) {
    final _$actionInfo =
        _$_MeterReadingControllerBaseActionController.startAction(
            name: '_MeterReadingControllerBase.setshowSubmitToDBLoader');
    try {
      return super.setshowSubmitToDBLoader(status);
    } finally {
      _$_MeterReadingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
meterReadingRecord: ${meterReadingRecord},
meterReadingDB: ${meterReadingDB},
showSubmitToDBLoader: ${showSubmitToDBLoader}
    ''';
  }
}
