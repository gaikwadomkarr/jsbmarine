import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/screens/authentication/login.dart';
import 'package:jsbmarineversion1/screens/main_screen.dart';
import 'package:jsbmarineversion1/utils/save_local_storage.dart';
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loggedin = false;
  @override
  void initState() {
    super.initState();
    getloggedin();
  }

  void getloggedin() async {
    loggedin = await Preferences.getUserLoggedIn();
    Future.delayed(const Duration(seconds: 2), () {
      if (loggedin) {
        Get.offAll(MainScreen());
      } else {
        Get.offAll(LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/AppLogo.jpg",
            height: 150,
          ),
        ),
      ),
    );
  }
}
