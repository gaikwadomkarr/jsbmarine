import 'package:get_storage/get_storage.dart';
import 'package:jsbmarineversion1/controller/all_entries_controller_mobx.dart';
import 'package:jsbmarineversion1/controller/login_controller_mobx.dart';

import '../api/mobx_api_calls.dart';
import '../controller/homepage_controller_mobx.dart';
import '../controller/meter_reading_controller_mobx.dart';

class DataConstants {
  static Future<GetStorage> getStorage = GetStorage() as Future<GetStorage>;
  static MobxApiCalls mobxApiCalls = MobxApiCalls();
  static LoginControllerMobx loginControllerMobx = LoginControllerMobx();
  static MeterReadingController meterReadingControllerMobx =
      MeterReadingController();
  static HomePageController homePageController = HomePageController();
  static AllEntriesControllerMobx allEntriesControllerMobx =
      AllEntriesControllerMobx();
  static String url = '';
  static String firebaseToken = '';
  static String uniqueId = "";
  static String username = "";
  static String branchID = "";
  static String branchName = "";
  static String userID = "";
  static int currentPage = 0;

  static String downloadDirectory = "";
  static bool canCreateImages = false;
}
