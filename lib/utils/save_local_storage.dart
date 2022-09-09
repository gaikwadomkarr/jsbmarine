import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jsbmarineversion1/screens/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static String UserIdKey = "USERID";
  static String UserLoggedInKey = "USERLOGINKEY";
  static String UserName = "USERNAME";
  static String userAppFirstTime = "USERAPPFIRSTTIME";
  static String UserTokenKey = "USERTOKEN";
  static String userBranchID = "USERROLE";
  static String userBranchName = "BRANCHNAME";
  static String dashboardlaunch = "DASHBOARTDLAUNCH";

//  static Prefrences _instance = new Prefrences.internal();
//  static Prefrences getInstance() {
//    return _instance;
//  }
//  Prefrences.internal();

  /**
   * User Login Prefrences
   */
  static void saveUserLoggedIn(bool isUserLoggedIn) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(UserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedIn() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(UserLoggedInKey) ?? false;
  }

  static void saveUserName(String username) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(UserName, username);
  }

  static Future<String> getUserName() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(UserName) ?? '';
  }

  /**
   * User token
   */
  static void saveToken(String token) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(UserTokenKey, token);
  }

  static Future<String> getToken() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(UserTokenKey) ?? '';
  }

  /**
   * User id
   */
  static void saveUserId(String userId) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(UserIdKey, userId);
  }

  static Future<String> getUserId() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(UserIdKey) ?? '';
  }

  /**
   * User role
   */

  static void saveBranchID(String brnachID) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(userBranchID, brnachID);
  }

  static Future<String> getBranchID() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(userBranchID) ?? '';
  }

  static void saveBranchname(String name) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(userBranchName, name);
  }

  static Future<String> getBranchName() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(userBranchName) ?? '';
  }

  static void clearCache() async {
    saveToken("");
    saveBranchID("");
    saveBranchname("");
    saveUserId("");
    saveUserName("");
    saveUserLoggedIn(false);
    Get.offAll(LoginScreen());
  }
}
