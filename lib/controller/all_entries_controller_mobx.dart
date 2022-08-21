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
  List<MeterReadingRecord> allconnections = [];
  @observable
  List<MeterReadingRecord> selectedConnections = ObservableList();

  @action
  void updateAllConnections(List<MeterReadingRecord> data) {
    allconnections.clear();
    allconnections = data;
  }

  @action
  Future<void> getallconnections() async {
    selectedConnectionsLoader = true;
    allconnections.clear();
    allconnections =
        await DataConstants.meterReadingControllerMobx.getConnections();
    selectedConnectionsLoader = false;
  }

  @action
  Future<void> getstatuswiseconnections(int index) async {
    selectedConnectionsLoader = true;
    allconnections.clear();
    allconnections = await DataConstants.meterReadingControllerMobx
        .getAllMeterReadingsByMeterStatus(index);
    selectedConnectionsLoader = false;
  }

  @action
  void addSelectedRecord(MeterReadingRecord meterReadingRecord) {
    selectedConnections.add(meterReadingRecord);
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
