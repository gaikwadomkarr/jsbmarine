import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/utils/WaterConnectionDBHelper.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/save_local_storage.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
import 'package:jsbmarineversion1/utils/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sizer/sizer.dart';

import 'screens/SplashScreen.dart';
import 'utils/color_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceId();
    getLocalStorage();
    getPermissions();
  }

  void getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.accessMediaLocation
    ].request();

    var locationStatus = await Permission.location;
    var storageStatus = await Permission.storage;
    var externalstorageStatus = await Permission.manageExternalStorage;
    log(locationStatus.toString());
    // if(locationStatus.isDenied ==){

    // }

    DataConstants.downloadDirectory = await Controller.getDownloadsDirectory();
    DataConstants.canCreateImages = await Controller.createPictureFolder();
  }

  void getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    DataConstants.uniqueId = deviceId!;
    log(DataConstants.uniqueId);
  }

  void getLocalStorage() async {
    TOKEN = await Preferences.getToken();
    DataConstants.branchID = await Preferences.getBranchID();
    DataConstants.branchName = await Preferences.getBranchName();
    DataConstants.userID = await Preferences.getUserId();
    DataConstants.username = await Preferences.getUserName();
    log("this is stored token $TOKEN");
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'JSB Marine',
          darkTheme: ThemeData.dark().copyWith(
              primaryColor: primaryColor,
              scaffoldBackgroundColor: white,
              // cardColor: const Color(0xFFF2F4F7),
              // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              //   backgroundColor: Color(0xFFF2F4F7),
              //   selectedItemColor: Color(0xFFD75B1F),
              // ),
              // textSelectionTheme: TextSelectionThemeData(
              //   cursorColor: const Color(0xFFD75B1F),
              //   selectionColor: const Color(0xFFD75B1F).withOpacity(0.5),
              //   selectionHandleColor: const Color(0xFFD75B1F),
              // ),
              // toggleableActiveColor: const Color(0xFFD75B1F),
              snackBarTheme: const SnackBarThemeData(
                backgroundColor: shade1,
              ),
              appBarTheme: const AppBarTheme(
                color: primaryColor,
                iconTheme: IconThemeData(
                  color: black, //change your color here
                ),
              ),
              brightness: Brightness.dark,
              colorScheme: const ColorScheme(
                      primary: Color(0xFFd4d8dd),
                      primaryVariant: Colors.red,
                      secondary: Color(0xFFD75B1F),
                      secondaryVariant: Colors.red,
                      surface: Colors.red,
                      background: Colors.red,
                      error: Colors.red,
                      onPrimary: Colors.red,
                      onSecondary: Color(0xFFF2F4F7),
                      onSurface: Colors.red,
                      onBackground: Colors.red,
                      onError: Colors.red,
                      brightness: Brightness.dark)
                  .copyWith(secondary: Colors.white)),
          home: SplashScreen(),
          themeMode: ThemeConstants.themeMode.value,
        );
      },
    );
  }
}
