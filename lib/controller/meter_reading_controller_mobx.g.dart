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

  late final _$deleteMeterReadingAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.deleteMeterReading',
      context: context);

  @override
  Future<bool> deleteMeterReading(int id, int meterStatus) {
    return _$deleteMeterReadingAsyncAction
        .run(() => super.deleteMeterReading(id, meterStatus));
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

  late final _$deleteMeterRecordAsyncAction = AsyncAction(
      '_MeterReadingControllerBase.deleteMeterRecord',
      context: context);

  @override
  Future<String> deleteMeterRecord(MeterReadingRecord meterReadingRecord) {
    return _$deleteMeterRecordAsyncAction
        .run(() => super.deleteMeterRecord(meterReadingRecord));
  }

  late final _$_MeterReadingControllerBaseActionController =
      ActionController(name: '_MeterReadingControllerBase', context: context);

  @override
  bool saveMeterReading(MeterReadingRecord meterReadingDb) {
    final _$actionInfo = _$_MeterReadingControllerBaseActionController
        .startAction(name: '_MeterReadingControllerBase.saveMeterReading');
    try {
      return super.saveMeterReading(meterReadingDb);
    } finally {
      _$_MeterReadingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
meterReadingRecord: ${meterReadingRecord},
meterReadingDB: ${meterReadingDB}
    ''';
  }
}
