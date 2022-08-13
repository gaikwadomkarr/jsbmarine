import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sizer/sizer.dart';

class Controller {
  // var theme = Theme.of(context);
  static TextStyle kblackNormalStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 15.sp, color: Colors.black);
  }

  // static void launchURL(String url) async {
  //   if (!await launch(url, enableJavaScript: true, forceWebView: true))
  //     throw 'Could not launch $url';
  // }

  static String formatDate(DateTime dateTime) {
    String dateFormat = DateFormat('hh:mm a').format(dateTime);
    return dateFormat;
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String camelToSentence(String text) {
    var result = text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
    var finalResult = result[0].toUpperCase() + result.substring(1);
    return finalResult;
  }

  static TextStyle kwhiteSemiBoldNormalStyle(
      BuildContext context, Color color) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 15.sp, color: color);
  }

  static TextStyle hintTextStyle(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          color: color ?? grey,
          fontSize: 12.sp,
        );
  }

  static TextStyle textFieldLabel(BuildContext context, {Color? color}) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
          color: color ?? grey,
          letterSpacing: 1,
          fontSize: 12.sp,
        );
  }

  static TextStyle pageHeadingLabel(BuildContext context, {Color? color}) {
    return TextStyle(
        fontSize: 22.sp,
        color: primaryColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 2);
  }

  static TextStyle textfieldTextStyle(BuildContext context, {Color? color}) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(color: black, letterSpacing: 1, fontSize: 13.sp);
  }

  static TextStyle buttonText(BuildContext context, {Color? color}) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(color: black, letterSpacing: 1, fontSize: 15.sp);
  }

  static TextStyle kwhiteSmallStyle(BuildContext context, Color color) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 10.sp, color: color);
  }

  static TextStyle kblackSemiNormalStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 12.sp, color: Colors.black);
  }

  static TextStyle kblackSemiBoldStyle(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.bold);
  }

  static Future<bool?> getInternetStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com',
          type: InternetAddressType.any);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  static void showErrorToast(String? msg, BuildContext context,
      {int duration = 3}) {
    showToastWidget(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.red),
        child: Text(
          msg!,
          textAlign: TextAlign.center,
          style: kblackSemiNormalStyle(context).copyWith(color: white),
        ),
      ),
      context: context,
      duration: Duration(seconds: duration),
      // backgroundColor: Colors.red,
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      animDuration: const Duration(milliseconds: 200),
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      // textAlign: TextAlign.center,
      // textStyle:
      //     Theme.of(context).textTheme.headline6!.copyWith(color: kwhite)
    );
  }

  static void showSuccessToast1(String? msg, BuildContext context,
      {int duration = 3}) {
    showToastWidget(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.green[700]),
        child: Text(
          msg!,
          textAlign: TextAlign.center,
          style: kblackSemiNormalStyle(context).copyWith(color: white),
        ),
      ),
      context: context,
      duration: Duration(seconds: duration),
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromTopFade,
      animDuration: const Duration(milliseconds: 200),
      reverseAnimation: StyledToastAnimation.slideToTopFade,
    );
  }

  // static Future<File> imgFromCamera() async {
  //   final pickedFile = await ImagePicker()
  //       .getImage(source: ImageSource.camera, imageQuality: 25);
  //   return File(pickedFile!.path);
  // }

  static Future<String> getDownloadsDirectory() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      log("Cannot get download folder path");
    }
    return directory!.path;
  }

  static Future<File?> imgFromCamera(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 15);
    if (pickedFile != null) {
      final bytes = await pickedFile.length();
      final kb = bytes / 1024;
      final mb = kb / 1024;
      // log('thiis is imagge size => $mb');
      if (mb > 2) {
        Controller.showErrorToast('Image size should be upto 2 mb', context);
        return null;
      }
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static Future<File> imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 25);
    return File(pickedFile!.path);
  }

  static showImagePicker(context) async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: primaryColor,
                      ),
                      title: Text(
                        'Gallery',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      onTap: () {
                        Navigator.of(context).pop('gallery');
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera, color: primaryColor),
                    title: Text('Camera',
                        style: Theme.of(context).textTheme.headline3),
                    onTap: () {
                      Navigator.of(context).pop('camera');
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<bool> createPictureFolder() async {
    bool cancreateimg = false;
    String meterreadingFolder = join(
      DataConstants.downloadDirectory,
      "MeterReading",
    );
    String picturesFolder =
        join(DataConstants.downloadDirectory, "MeterReading", "Pictures");
    String dateFolder = join(DataConstants.downloadDirectory, "MeterReading",
        "Pictures", DateFormat("dd-MM-yyyy").format(DateTime.now()));

    Directory outputFile = Directory(meterreadingFolder);
    Directory pictureFile = Directory(picturesFolder);
    Directory dateFile = Directory(dateFolder);

    if (outputFile.existsSync()) {
      log("meter reading folder already exists");
      if (pictureFile.existsSync()) {
        if (dateFile.existsSync()) {
          cancreateimg = true;
        } else {
          await dateFile.create().then((value) {
            log('this is date folder dir $value');
            cancreateimg = true;
          }).onError((error, stackTrace) {
            log(error.toString());
          });
        }
      } else {
        await pictureFile.create().then((value) async {
          log('this is picture folder dir $value');

          await dateFile.create().then((value) {
            log('this is date folder dir $value');
            cancreateimg = true;
          }).onError((error, stackTrace) {
            log(error.toString());
          });
        }).onError((error, stackTrace) {
          log(error.toString());
        });
      }
    } else {
      await outputFile.create().then((value) {
        log('this is meterreading folder dir $value');
      }).onError((error, stackTrace) {
        log(error.toString());
      });
      await pictureFile.create().then((value) {
        log('this is picture folder dir $value');
      }).onError((error, stackTrace) {
        log(error.toString());
      });
      await dateFile.create().then((value) {
        log('this is date folder dir $value');
        cancreateimg = true;
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }

    return cancreateimg;
  }
}
