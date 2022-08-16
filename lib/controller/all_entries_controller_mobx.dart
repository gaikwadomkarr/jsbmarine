import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:mobx/mobx.dart';
part 'all_entries_controller_mobx.g.dart';

class AllEntriesControllerMobx = _AllEntriesControllerMobxBase
    with _$AllEntriesControllerMobx;

abstract class _AllEntriesControllerMobxBase with Store {
  @observable
  bool allConnectionsLoader = false;

  @observable
  List<MeterReadingRecord> allconnections = [];

  @action
  void updateAllConnections(List<MeterReadingRecord> data) {
    allconnections.clear();
    allconnections = data;
  }
}
