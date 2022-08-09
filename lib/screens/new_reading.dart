import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
import 'package:jsbmarineversion1/widgets/c_gradient_button.dart';
import 'package:jsbmarineversion1/widgets/c_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as p;
import '../utils/WaterConnectionDBHelper.dart';

class NewReadingPage extends StatefulWidget {
  const NewReadingPage({Key? key}) : super(key: key);

  @override
  State<NewReadingPage> createState() => _NewReadingPageState();
}

class _NewReadingPageState extends State<NewReadingPage> {
  String consumerNumber = "", meterReading = "";
  int meterStatus = 0;
  File? meterReadingImage;
  String? selectedStatusValue = "1";
  var pngByteData;
  String imagebase64 = "";
  Position? _currentPosition;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    WaterConnectionDBHelper().meterreadingDb;
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      setState(() {
        _currentPosition = value;
      });
    });
    log(_currentPosition!.latitude.toString() +
        _currentPosition!.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: shade4,
      body: SingleChildScrollView(
        child: Container(
          height: 85.h,
          margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          // padding: MediaQuery.of(context).viewInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Consumer Number",
                style: Controller.kwhiteSmallStyle(context, primaryColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                // margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(3.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CTextField(
                      onSaved: (value) {
                        setState(() {
                          consumerNumber = value;
                        });
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hint_text: "Consumer Number",
                      textfieldBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(2.h)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Meter Reading",
                style: Controller.kwhiteSmallStyle(context, primaryColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                // margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(3.w)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (consumerNumber.isEmpty) {
                          Get.showSnackbar(
                              errorSnackBar('Please enter Consumer number'));
                          return;
                        }
                        var image = await Controller.imgFromCamera(context);
                        if (image != null) {
                          setState(() {
                            meterReadingImage = image;
                          });
                          pngByteData = await meterReadingImage!.readAsBytes();
                          imagebase64 = base64Encode(pngByteData);
                          final directory =
                              await Controller.getDownloadsDirectory();
                          Directory outputFile = Directory(directory +
                              "/MeterReading/Pictures/${DateFormat("dd-MM-yyyy").format(DateTime.now())}");

                          if (outputFile.existsSync()) {
                            log("file already exists");
                          } else {
                            outputFile.create().then(
                                (value) => log('this is image dir $value'));
                          }
                          File file = File(
                              "${outputFile.path}/$consumerNumber${p.extension(meterReadingImage!.path)}");
                          await file.writeAsBytes(pngByteData);
                          // log(imagebase64.toString());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 15.w,
                          backgroundImage: meterReadingImage != null
                              ? FileImage(meterReadingImage!)
                              : null,
                          backgroundColor: grey,
                          child: Icon(
                            Icons.photo_camera,
                            color: white,
                            size: 10.w,
                          ),
                        ),
                      ),
                    ),
                    CTextField(
                      onSaved: (value) {
                        setState(() {
                          meterReading = value;
                        });
                      },
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hint_text: "Meter Reading",
                      textfieldBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(2.h)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Meter Status",
                style: Controller.kwhiteSmallStyle(context, primaryColor),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  // margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(3.w)),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    // runSpacing: 2,
                    spacing: 2.w,
                    children: List.generate(meterStatusList.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStatusValue = meterStatusNoList[index];
                            meterStatus = int.parse(meterStatusNoList[index]);
                          });
                          log(selectedStatusValue.toString());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                                value: meterStatusNoList[index],
                                groupValue: selectedStatusValue,
                                activeColor: primaryColor,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green),
                                onChanged: (String? value) {}),
                            Text(
                              meterStatusList[index],
                              style: Controller.kblackSemiNormalStyle(context),
                            )
                          ],
                        ),
                      );
                    }),
                  )),
              // SizedBox(
              //   height: 2.h,
              // ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: CGradientButton(
                  buttonName: "SUBMIT",
                  onPress: () {
                    addReading();
                  },
                  color: primaryColor,
                  height: 7.h,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void addReading() async {
    final createDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    if (consumerNumber.isEmpty) {
      Get.showSnackbar(errorSnackBar('Please enter Consumer Number'));
      return;
    }
    if (imagebase64.isEmpty) {
      Get.showSnackbar(errorSnackBar('Please take photo of meter'));
      return;
    }
    if (meterReading.isEmpty) {
      Get.showSnackbar(errorSnackBar('Please enter Meter Reading'));
      return;
    }
    if (selectedStatusValue == 0) {
      Get.showSnackbar(errorSnackBar('Please select meter status'));
      return;
    }
    dio.FormData formData = dio.FormData.fromMap({
      "deviceId": DataConstants.uniqueId,
      "scanDate": createDate,
      "meterReading": meterReading,
      "barcode": consumerNumber,
      "miterNumber": consumerNumber,
      "userID": DataConstants.userID,
      "branchID": DataConstants.branchID,
      "latitude": "19.78",
      "longitude": "28.63",
      "locationName": "null",
      "imageBase64": imagebase64,
      "meterStatus": meterStatus
    });

    debugPrint(formData.fields.toString());

    final meterReadingRecord = MeterReadingRecord(
        deviceId: DataConstants.uniqueId,
        scanDate: DateTime.now().toString(),
        meterReading: int.parse(meterReading),
        barcode: int.parse(consumerNumber),
        miterNumber: consumerNumber,
        userID: int.parse(DataConstants.userID),
        branchID: int.parse(DataConstants.branchID),
        latitude: "19.78",
        longitude: "28.63",
        locationName: null,
        imageBase64: imagebase64,
        meterStatus: meterStatus,
        meterImage: meterReadingImage!.path,
        uploadStatus: "No");
    DataConstants.meterReadingControllerMobx
        .saveMeterReading(meterReadingRecord);
    DataConstants.meterReadingControllerMobx.getConnections();
  }
}
