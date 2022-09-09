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

  late final _$selectedConnectionsLoaderAtom = Atom(
      name: '_AllEntriesControllerMobxBase.selectedConnectionsLoader',
      context: context);

  @override
  bool get selectedConnectionsLoader {
    _$selectedConnectionsLoaderAtom.reportRead();
    return super.selectedConnectionsLoader;
  }

  @override
  set selectedConnectionsLoader(bool value) {
    _$selectedConnectionsLoaderAtom
        .reportWrite(value, super.selectedConnectionsLoader, () {
      super.selectedConnectionsLoader = value;
    });
  }

  late final _$uploadEntryLoaderAtom = Atom(
      name: '_AllEntriesControllerMobxBase.uploadEntryLoader',
      context: context);

  @override
  bool get uploadEntryLoader {
    _$uploadEntryLoaderAtom.reportRead();
    return super.uploadEntryLoader;
  }

  @override
  set uploadEntryLoader(bool value) {
    _$uploadEntryLoaderAtom.reportWrite(value, super.uploadEntryLoader, () {
      super.uploadEntryLoader = value;
    });
  }

  late final _$reloadEntryLoaderAtom = Atom(
      name: '_AllEntriesControllerMobxBase.reloadEntryLoader',
      context: context);

  @override
  bool get reloadEntryLoader {
    _$reloadEntryLoaderAtom.reportRead();
    return super.reloadEntryLoader;
  }

  @override
  set reloadEntryLoader(bool value) {
    _$reloadEntryLoaderAtom.reportWrite(value, super.reloadEntryLoader, () {
      super.reloadEntryLoader = value;
    });
  }

  late final _$remainingUploadsAtom = Atom(
      name: '_AllEntriesControllerMobxBase.remainingUploads', context: context);

  @override
  int get remainingUploads {
    _$remainingUploadsAtom.reportRead();
    return super.remainingUploads;
  }

  @override
  set remainingUploads(int value) {
    _$remainingUploadsAtom.reportWrite(value, super.remainingUploads, () {
      super.remainingUploads = value;
    });
  }

  late final _$selectedStatusAtom = Atom(
      name: '_AllEntriesControllerMobxBase.selectedStatus', context: context);

  @override
  int get selectedStatus {
    _$selectedStatusAtom.reportRead();
    return super.selectedStatus;
  }

  @override
  set selectedStatus(int value) {
    _$selectedStatusAtom.reportWrite(value, super.selectedStatus, () {
      super.selectedStatus = value;
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

  late final _$searchedconnectionsAtom = Atom(
      name: '_AllEntriesControllerMobxBase.searchedconnections',
      context: context);

  @override
  List<MeterReadingRecord> get searchedconnections {
    _$searchedconnectionsAtom.reportRead();
    return super.searchedconnections;
  }

  @override
  set searchedconnections(List<MeterReadingRecord> value) {
    _$searchedconnectionsAtom.reportWrite(value, super.searchedconnections, () {
      super.searchedconnections = value;
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

  late final _$isAllSelectedAtom = Atom(
      name: '_AllEntriesControllerMobxBase.isAllSelected', context: context);

  @override
  bool get isAllSelected {
    _$isAllSelectedAtom.reportRead();
    return super.isAllSelected;
  }

  @override
  set isAllSelected(bool value) {
    _$isAllSelectedAtom.reportWrite(value, super.isAllSelected, () {
      super.isAllSelected = value;
    });
  }

  late final _$showSearchedResultsAtom = Atom(
      name: '_AllEntriesControllerMobxBase.showSearchedResults',
      context: context);

  @override
  bool get showSearchedResults {
    _$showSearchedResultsAtom.reportRead();
    return super.showSearchedResults;
  }

  @override
  set showSearchedResults(bool value) {
    _$showSearchedResultsAtom.reportWrite(value, super.showSearchedResults, () {
      super.showSearchedResults = value;
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

  late final _$removeMultipleRecordAsyncAction = AsyncAction(
      '_AllEntriesControllerMobxBase.removeMultipleRecord',
      context: context);

  @override
  Future<void> removeMultipleRecord(
      List<MeterReadingRecord> meterReadingRecords) {
    return _$removeMultipleRecordAsyncAction
        .run(() => super.removeMultipleRecord(meterReadingRecords));
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
  void searchbyconsumernumber(String consumernumber) {
    final _$actionInfo =
        _$_AllEntriesControllerMobxBaseActionController.startAction(
            name: '_AllEntriesControllerMobxBase.searchbyconsumernumber');
    try {
      return super.searchbyconsumernumber(consumernumber);
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStatus(dynamic status) {
    final _$actionInfo = _$_AllEntriesControllerMobxBaseActionController
        .startAction(name: '_AllEntriesControllerMobxBase.setSelectedStatus');
    try {
      return super.setSelectedStatus(status);
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsAllSelected(bool status) {
    final _$actionInfo = _$_AllEntriesControllerMobxBaseActionController
        .startAction(name: '_AllEntriesControllerMobxBase.setIsAllSelected');
    try {
      return super.setIsAllSelected(status);
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
selectedConnectionsLoader: ${selectedConnectionsLoader},
uploadEntryLoader: ${uploadEntryLoader},
reloadEntryLoader: ${reloadEntryLoader},
remainingUploads: ${remainingUploads},
selectedStatus: ${selectedStatus},
allconnections: ${allconnections},
searchedconnections: ${searchedconnections},
selectedConnections: ${selectedConnections},
isAllSelected: ${isAllSelected},
showSearchedResults: ${showSearchedResults}
    ''';
  }
}
