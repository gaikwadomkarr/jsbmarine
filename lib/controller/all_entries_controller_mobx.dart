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
  List<MeterReadingRecord> allconnections = [];
  @observable
  List<MeterReadingRecord> selectedConnections = [];

  @action
  void updateAllConnections(List<MeterReadingRecord> data) {
    allconnections.clear();
    allconnections = data;
  }

  @action
  Future<void> getallconnections() async {
    allconnections.clear();
    allconnections =
        await DataConstants.meterReadingControllerMobx.getConnections();
  }

  @action
  Future<void> getstatuswiseconnections(int index) async {
    allconnections.clear();
    allconnections = await DataConstants.meterReadingControllerMobx
        .getAllMeterReadingsByMeterStatus(index);
  }

  @action
  void addSelectedRecord(MeterReadingRecord meterReadingRecord) {
    selectedConnections.add(meterReadingRecord);
  }

  @action
  void removeSelectedRecord(MeterReadingRecord meterReadingRecord) {
    selectedConnections.remove(meterReadingRecord);
  }

  @action
  void emptyselectedRecord() {
    selectedConnections.clear();
  }
}
