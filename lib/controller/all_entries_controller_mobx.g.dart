// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_entries_controller_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AllEntriesControllerMobx on _AllEntriesControllerMobxBase, Store {
  late final _$allConnectionsLoaderAtom = Atom(
      name: '_AllEntriesControllerMobxBase.allConnectionsLoader',
      context: context);

  @override
  bool get allConnectionsLoader {
    _$allConnectionsLoaderAtom.reportRead();
    return super.allConnectionsLoader;
  }

  @override
  set allConnectionsLoader(bool value) {
    _$allConnectionsLoaderAtom.reportWrite(value, super.allConnectionsLoader,
        () {
      super.allConnectionsLoader = value;
    });
  }

  late final _$allconnectionsAtom = Atom(
      name: '_AllEntriesControllerMobxBase.allconnections', context: context);

  @override
  List<MeterReadingRecord> get allconnections {
    _$allconnectionsAtom.reportRead();
    return super.allconnections;
  }

  @override
  set allconnections(List<MeterReadingRecord> value) {
    _$allconnectionsAtom.reportWrite(value, super.allconnections, () {
      super.allconnections = value;
    });
  }

  late final _$selectedConnectionsAtom = Atom(
      name: '_AllEntriesControllerMobxBase.selectedConnections',
      context: context);

  @override
  List<MeterReadingRecord> get selectedConnections {
    _$selectedConnectionsAtom.reportRead();
    return super.selectedConnections;
  }

  @override
  set selectedConnections(List<MeterReadingRecord> value) {
    _$selectedConnectionsAtom.reportWrite(value, super.selectedConnections, () {
      super.selectedConnections = value;
    });
  }

  late final _$getallconnectionsAsyncAction = AsyncAction(
      '_AllEntriesControllerMobxBase.getallconnections',
      context: context);

  @override
  Future<void> getallconnections() {
    return _$getallconnectionsAsyncAction.run(() => super.getallconnections());
  }

  late final _$getstatuswiseconnectionsAsyncAction = AsyncAction(
      '_AllEntriesControllerMobxBase.getstatuswiseconnections',
      context: context);

  @override
  Future<void> getstatuswiseconnections(int index) {
    return _$getstatuswiseconnectionsAsyncAction
        .run(() => super.getstatuswiseconnections(index));
  }

  late final _$_AllEntriesControllerMobxBaseActionController =
      ActionController(name: '_AllEntriesControllerMobxBase', context: context);

  @override
  void updateAllConnections(List<MeterReadingRecord> data) {
    final _$actionInfo =
        _$_AllEntriesControllerMobxBaseActionController.startAction(
            name: '_AllEntriesControllerMobxBase.updateAllConnections');
    try {
      return super.updateAllConnections(data);
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedRecord(MeterReadingRecord meterReadingRecord) {
    final _$actionInfo = _$_AllEntriesControllerMobxBaseActionController
        .startAction(name: '_AllEntriesControllerMobxBase.addSelectedRecord');
    try {
      return super.addSelectedRecord(meterReadingRecord);
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedRecord(MeterReadingRecord meterReadingRecord) {
    final _$actionInfo =
        _$_AllEntriesControllerMobxBaseActionController.startAction(
            name: '_AllEntriesControllerMobxBase.removeSelectedRecord');
    try {
      return super.removeSelectedRecord(meterReadingRecord);
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void emptyselectedRecord() {
    final _$actionInfo = _$_AllEntriesControllerMobxBaseActionController
        .startAction(name: '_AllEntriesControllerMobxBase.emptyselectedRecord');
    try {
      return super.emptyselectedRecord();
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allConnectionsLoader: ${allConnectionsLoader},
allconnections: ${allconnections},
selectedConnections: ${selectedConnections}
    ''';
  }
}
