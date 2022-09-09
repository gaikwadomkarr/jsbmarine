import 'dart:async';

import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:mobx/mobx.dart';
part 'all_entries_controller_mobx.g.dart';

class AllEntriesControllerMobx = _AllEntriesControllerMobxBase
    with _$AllEntriesControllerMobx;

abstract class _AllEntriesControllerMobxBase with Store {
  @observable
  bool allConnectionsLoader = false;
  @observable
  bool selectedConnectionsLoader = false;
  @observable
  bool uploadEntryLoader = false;
  @observable
  bool reloadEntryLoader = false;
  @observable
  int remainingUploads = 0;
  @observable
  int selectedStatus = 0;
  @observable
  List<MeterReadingRecord> allconnections = [];
  @observable
  List<MeterReadingRecord> searchedconnections = [];
  @observable
  List<MeterReadingRecord> selectedConnections = ObservableList();
  @observable
  bool isAllSelected = false;
  @observable
  bool showSearchedResults = false;
  late final Timer _timer;

  late StreamController<List<MeterReadingRecord>> streamController =
      StreamController<List<MeterReadingRecord>>();

  late Stream<List<MeterReadingRecord>> recordsstream =
      streamController.stream.asBroadcastStream();

  late ObservableStream<List<MeterReadingRecord>?> randomStream;

  // _AllEntriesControllerMobx() {
  //   streamController = StreamController<List<MeterReadingRecord>>();
  //   streamController.sink
  //       .add(DataConstants.allEntriesControllerMobx.allconnections);
  //   randomStream = ObservableStream(streamController.stream);
  // }

  @action
  void updateAllConnections(List<MeterReadingRecord> data) {
    allconnections.clear();
    searchedconnections.clear();
    remainingUploads = 0;
    allconnections = data;
    allconnections.forEach((e) {
      if (e.uploadStatus == "No") {
        remainingUploads += 1;
      }
    });

    // streamController.sink.add(allconnections);
  }

  @action
  void searchbyconsumernumber(String consumernumber) {
    searchedconnections.clear();
    allconnections.forEach((element) {
      if (element.barcode!.startsWith(consumernumber)) {
        searchedconnections.add(element);
      }
    });
    if (searchedconnections.isNotEmpty) showSearchedResults = true;
  }

  @action
  Future<void> getallconnections() async {
    allConnectionsLoader = true;
    selectedConnectionsLoader = true;
    allconnections.clear();
    searchedconnections.clear();
    remainingUploads = 0;
    allconnections =
        await DataConstants.meterReadingControllerMobx.getConnections();
    allconnections.forEach((e) {
      if (e.uploadStatus == "No") {
        remainingUploads += 1;
      }
    });
    allConnectionsLoader = false;
    selectedConnectionsLoader = false;
  }

  @action
  Future<void> getstatuswiseconnections(int index) async {
    allConnectionsLoader = true;
    selectedConnectionsLoader = true;
    allconnections.clear();
    searchedconnections.clear();
    remainingUploads = 0;
    allconnections = await DataConstants.meterReadingControllerMobx
        .getAllMeterReadingsByMeterStatus(index);
    allconnections.forEach((e) {
      if (e.uploadStatus == "No") {
        remainingUploads += 1;
      }
    });
    allConnectionsLoader = false;
    selectedConnectionsLoader = false;
  }

  @action
  void setSelectedStatus(var status) {
    selectedStatus = status;
  }

  @action
  void setIsAllSelected(bool status) {
    isAllSelected = status;
    if (isAllSelected) {
      selectedConnections.clear();
      // if (showSearchedResults) {
      //   selectedConnections.addAll(searchedconnections);
      // } else {
      selectedConnections.addAll(allconnections);
      // }
    } else {
      selectedConnections.clear();
    }
  }

  @action
  void addSelectedRecord(MeterReadingRecord meterReadingRecord) {
    selectedConnections.add(meterReadingRecord);
  }

  @action
  Future<void> removeMultipleRecord(
      List<MeterReadingRecord> meterReadingRecords) async {
    meterReadingRecords.forEach((element) async {
      var exists =
          await DataConstants.meterReadingControllerMobx.recordExists(element);
      if (exists) {
        selectedConnections.remove(element);
      }
    });
  }

  @action
  void removeSelectedRecord(MeterReadingRecord meterReadingRecord) {
    selectedConnections.removeWhere((element) => element == meterReadingRecord);
  }

  @action
  void emptyselectedRecord() {
    selectedConnections.clear();
  }
}
