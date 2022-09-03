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
  List<MeterReadingRecord> selectedConnections = ObservableList();

  @action
  void updateAllConnections(List<MeterReadingRecord> data) {
    allconnections.clear();
    remainingUploads = 0;
    allconnections = data;
    allconnections.forEach((e) {
      if (e.uploadStatus == "No") {
        remainingUploads += 1;
      }
    });
  }

  @action
  Future<void> getallconnections() async {
    selectedConnectionsLoader = true;
    allconnections.clear();
    remainingUploads = 0;
    allconnections =
        await DataConstants.meterReadingControllerMobx.getConnections();
    allconnections.forEach((e) {
      if (e.uploadStatus == "No") {
        remainingUploads += 1;
      }
    });
    selectedConnectionsLoader = false;
  }

  @action
  Future<void> getstatuswiseconnections(int index) async {
    selectedConnectionsLoader = true;
    allconnections.clear();
    remainingUploads = 0;
    allconnections = await DataConstants.meterReadingControllerMobx
        .getAllMeterReadingsByMeterStatus(index);
    allconnections.forEach((e) {
      if (e.uploadStatus == "No") {
        remainingUploads += 1;
      }
    });
    selectedConnectionsLoader = false;
  }

  @action
  void setSelectedStatus(var status) {
    selectedStatus = status;
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
