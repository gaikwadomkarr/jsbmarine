import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/screens/main_screen.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:jsbmarineversion1/widgets/c_gradient_button.dart';
import 'package:jsbmarineversion1/widgets/c_textfield.dart';
import 'package:jsbmarineversion1/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

import '../../utils/data_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPass = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: shade2,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/AppLogo.jpg",
                  height: 150,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CTextField(
                  controller: usernameController,
                  hint_text: "Username",
                  style: Controller.kblackSemiNormalStyle(context),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType:
                      const TextInputType.numberWithOptions(signed: true),
                  textInputAction: TextInputAction.next,
                  textfieldBorder: CommonView.enableBorder,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CTextField(
                  controller: passwordController,
                  hint_text: "Password",
                  isPassword: isPass,
                  suffixIcon: GestureDetector(
                    onTap: (() {
                      setState(() {
                        isPass = !isPass;
                      });
                    }),
                    child: isPass
                        ? const Icon(
                            Icons.visibility_rounded,
                            color: black,
                          )
                        : const Icon(
                            Icons.visibility_off_sharp,
                            color: black,
                          ),
                  ),
                  style: Controller.kblackSemiNormalStyle(context),
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textfieldBorder: CommonView.enableBorder,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Observer(builder: (context) {
                  return CGradientButton(
                    buttonName:
                        DataConstants.loginControllerMobx.showLoginLoader
                            ? ""
                            : "LOGIN",
                    color: primaryColor,
                    height: 7.h,
                    onPress: DataConstants.loginControllerMobx.showLoginLoader
                        ? null
                        : callLoginApi,
                    icon: DataConstants.loginControllerMobx.showLoginLoader
                        ? const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: white,
                          )
                        : null,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void callLoginApi() {
    FocusScope.of(context).unfocus();
    // Get.to(MainScreen());
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.showSnackbar(errorSnackBar('Please enter Username and Password'));
      return;
    }
    Map<String, dynamic> map = {
      "UserName": usernameController.text,
      "Password": passwordController.text,
      "grant_type": "password",
      "IMENumber": ""
    };
    debugPrint("Login ${jsonEncode(map)}");
    // return;
    DataConstants.loginControllerMobx.showLoginLoader = true;
    Controller.getInternetStatus().then((value) {
      // print("this is internet status $value ");
      if (value == true) {
        DataConstants.mobxApiCalls.loginApiCall(map);
      } else {
        DataConstants.loginControllerMobx.showLoginLoader = false;
        Get.showSnackbar(errorSnackBar('No Internet Connection!'));
      }
    });
  }
}
