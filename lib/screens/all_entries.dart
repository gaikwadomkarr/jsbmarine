import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jsbmarineversion1/controller/meter_reading_controller_mobx.dart';
import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/save_local_storage.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
import 'package:jsbmarineversion1/widgets/c_gradient_button.dart';
import 'package:jsbmarineversion1/widgets/c_textfield.dart';
import 'package:sizer/sizer.dart';

class AllEntries extends StatefulWidget {
  const AllEntries({Key? key}) : super(key: key);

  @override
  State<AllEntries> createState() => _AllEntriesState();
}

class _AllEntriesState extends State<AllEntries> {
  int selectedStatus = 0;
  bool showCross = false;
  String branchName = "";
  TextEditingController searchCOntroller = TextEditingController();
  List<MeterReadingRecord> meterRecords = [];
  GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getConnections();
    getNonUploadedRecords();
    if (DataConstants.branchName == "") {
      DataConstants.mobxApiCalls.getBranchDetails();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    DataConstants.allEntriesControllerMobx.selectedStatus = 0;
    super.dispose();
  }

  void getConnections() async {
    // setState(() {
    //   DataConstants.allEntriesControllerMobx.allConnectionsLoader = true;
    // });
    DataConstants.allEntriesControllerMobx.allconnections.clear();
    var allconnections =
        await DataConstants.meterReadingControllerMobx.getConnections();
    DataConstants.allEntriesControllerMobx.updateAllConnections(allconnections);
    // setState(() {
    //   DataConstants.allEntriesControllerMobx.allConnectionsLoader = false;
    // });
    DataConstants.allEntriesControllerMobx.selectedConnections.clear();
    // log(allconnections.toString());
  }

  Future<void> getNonUploadedRecords() async {
    meterRecords = await DataConstants.meterReadingControllerMobx
        .getLimitedMeterReadingsByStatus("No");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldState,
            backgroundColor: shade4,
            body: Observer(builder: (context) {
              return IgnorePointer(
                ignoring:
                    DataConstants.allEntriesControllerMobx.uploadEntryLoader,
                child: Column(
                  children: [
                    Container(
                      color: shade2,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Observer(builder: (context) {
                          //   return
                          DataConstants.loginControllerMobx.showGetBranchLoader
                              ? SizedBox(
                                  height: 3.h,
                                  width: 3.h,
                                  child: const CircularProgressIndicator(
                                    backgroundColor: primaryColor,
                                    strokeWidth: 4,
                                  ),
                                )
                              : Text(
                                  "Branch - ${DataConstants.branchName}",
                                  style: Controller.kwhiteSmallStyle(
                                      context, white),
                                ),
                          // }),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Total Entries - ${DataConstants.allEntriesControllerMobx.allconnections.length}",
                            style: Controller.kwhiteSmallStyle(context, white),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Remaining Entries - ${DataConstants.allEntriesControllerMobx.remainingUploads}",
                            style: Controller.kwhiteSmallStyle(context, white),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    Container(
                        color: shade4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            buildSearchBox(),
                            SizedBox(
                              height: 1.h,
                            ),
                            buildMeterStatusFilter(),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        )),

                    buildMeterRecord(),
                    Observer(builder: (context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IgnorePointer(
                              ignoring: meterRecords.isEmpty,
                              child: CGradientButton(
                                  buttonName: DataConstants
                                          .allEntriesControllerMobx
                                          .uploadEntryLoader
                                      ? ''
                                      : 'Upload',
                                  onPress: DataConstants
                                          .allEntriesControllerMobx
                                          .uploadEntryLoader
                                      ? null
                                      : () {
                                          if (meterRecords.isNotEmpty) {
                                            uploadEntry();
                                          } else {
                                            Get.showSnackbar(errorSnackBar(
                                                'No records to upload'));
                                          }
                                        },
                                  color: meterRecords.isEmpty
                                      ? grey
                                      : primaryColor,
                                  icon: DataConstants.allEntriesControllerMobx
                                          .uploadEntryLoader
                                      ? const CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: white,
                                        )
                                      : null),
                            ),
                            IgnorePointer(
                              ignoring: DataConstants.allEntriesControllerMobx
                                  .selectedConnections.isEmpty,
                              child: CGradientButton(
                                  buttonName: DataConstants
                                          .allEntriesControllerMobx
                                          .reloadEntryLoader
                                      ? ''
                                      : 'Reload',
                                  onPress: DataConstants
                                          .allEntriesControllerMobx
                                          .reloadEntryLoader
                                      ? null
                                      : () async {
                                          reloadEntry();
                                        },
                                  color: DataConstants.allEntriesControllerMobx
                                          .selectedConnections.isEmpty
                                      ? grey
                                      : primaryColor,
                                  icon: DataConstants.allEntriesControllerMobx
                                          .reloadEntryLoader
                                      ? const CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: white,
                                        )
                                      : null),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 1.h,
                    )
                  ],
                ),
              );
            })));
  }

  Widget buildSearchBox() {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        color: shade4,
        child: CTextField(
          hint_text: 'Search Consumer Number',
          hintTextStyle: Controller.hintTextStyle(context),
          controller: searchCOntroller,
          onSaved: (value) {
            if (value.isNotEmpty) {
              setState(() {
                showCross = true;
              });
              DataConstants.allEntriesControllerMobx
                  .searchbyconsumernumber(searchCOntroller.text);
            } else {
              setState(() {
                DataConstants.allEntriesControllerMobx.showSearchedResults =
                    false;
                showCross = false;
              });
            }
          },
          suffixIcon: showCross
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      DataConstants
                          .allEntriesControllerMobx.showSearchedResults = false;
                      searchCOntroller.clear();
                      showCross = false;
                    });
                  },
                  child: const Icon(
                    FlutterIcons.close_ant,
                    color: Colors.red,
                  ))
              : null,
        ));
  }

  Widget buildMeterStatusFilter() {
    return Container(
      width: double.infinity,
      height: 5.h,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: allmeterStatusList.length,
          itemBuilder: ((context, index) {
            return Observer(builder: (context) {
              return GestureDetector(
                onTap: () async {
                  DataConstants.allEntriesControllerMobx.setSelectedStatus(
                      int.parse(allmeterStatusNoList[index]));
                  DataConstants.allEntriesControllerMobx
                      .setIsAllSelected(false);
                  log(DataConstants.allEntriesControllerMobx.selectedStatus
                      .toString());
                  DataConstants.allEntriesControllerMobx.emptyselectedRecord();
                  if (index == 0) {
                    DataConstants.allEntriesControllerMobx.getallconnections();
                  } else {
                    DataConstants.allEntriesControllerMobx
                        .getstatuswiseconnections(DataConstants
                            .allEntriesControllerMobx.selectedStatus);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: BoxDecoration(
                    color:
                        DataConstants.allEntriesControllerMobx.selectedStatus ==
                                index
                            ? primaryColor
                            : grey,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    allmeterStatusList[index],
                    style: Controller.kwhiteSmallStyle(context, white),
                  ),
                ),
              );
            });
          })),
    );
  }

  Widget buildMeterRecords() {
    return StreamBuilder<List<MeterReadingRecord>>(
      stream: DataConstants.allEntriesControllerMobx.streamController.stream,
      builder: (context, AsyncSnapshot<List<MeterReadingRecord>> snapshot) {
        print("this is snapshot data => ${snapshot.data}");
        print("this is snapshot data => ${snapshot.connectionState}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: primaryColor,
              ),
            );
          case ConnectionState.active:
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) {
                      var meterReadingRecord = DataConstants
                          .allEntriesControllerMobx.allconnections[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 5.w),
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0.h, horizontal: 2.w),
                            tileColor: meterReadingRecord.uploadStatus == "No"
                                ? Colors.green[100]
                                : white,
                            onTap: () {
                              // if (DataConstants
                              //         .allEntriesControllerMobx.selectedConnections.length ==
                              //     1) {
                              //   Get.showSnackbar(errorSnackBar('You can select only one'));
                              // } else {
                              if (DataConstants
                                  .allEntriesControllerMobx.selectedConnections
                                  .contains(meterReadingRecord)) {
                                DataConstants.allEntriesControllerMobx
                                    .removeSelectedRecord(meterReadingRecord);
                              } else {
                                DataConstants.allEntriesControllerMobx
                                    .addSelectedRecord(meterReadingRecord);
                              }
                            },
                            leading: CircleAvatar(
                              radius: 7.w,
                              backgroundImage: FileImage(
                                  File(meterReadingRecord.meterImage!)),
                            ),
                            title: RichText(
                              text: TextSpan(
                                  text: 'Consumer Number : ',
                                  style: Controller.kwhiteSmallStyle(
                                      context, shade2),
                                  children: [
                                    TextSpan(
                                        text: meterReadingRecord.barcode!
                                            .toString(),
                                        style: Controller.kwhiteSmallStyle(
                                            context, black))
                                  ]),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                  text: 'Meter Reading : ',
                                  style: Controller.kwhiteSmallStyle(
                                      context, shade2),
                                  children: [
                                    TextSpan(
                                        text: meterReadingRecord.meterReading!
                                            .toString(),
                                        style: Controller.kwhiteSmallStyle(
                                            context, black))
                                  ]),
                            ),
                            trailing: Observer(builder: (context) {
                              return DataConstants.allEntriesControllerMobx
                                      .selectedConnections
                                      .contains(meterReadingRecord)
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                    )
                                  : const Icon(
                                      Icons.check_circle_outline,
                                      color: shade4,
                                    );
                            })),
                      );
                    }))
                : Center(
                    child: Text(
                      'No Entries found!',
                      style: Controller.kblackNormalStyle(context),
                    ),
                  );
          default:
            return Center(
              child: Text(
                'No Entries found!',
                style: Controller.kblackNormalStyle(context),
              ),
            );
        }
      },
    );
  }

  Widget buildMeterRecord() {
    return Observer(builder: (context) {
      return Expanded(
          child: DataConstants.allEntriesControllerMobx.allConnectionsLoader
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        strokeWidth: 4,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Please wait while we load data\nThis may take some time',
                        textAlign: TextAlign.center,
                        style: Controller.kblackSemiNormalStyle(context),
                      )
                    ],
                  ),
                )
              : DataConstants.allEntriesControllerMobx.showSearchedResults
                  ? recordBuilder(DataConstants
                      .allEntriesControllerMobx.searchedconnections)
                  : recordBuilder(
                      DataConstants.allEntriesControllerMobx.allconnections));
    });
  }

  Widget recordBuilder(List<MeterReadingRecord> meterRecords) {
    return meterRecords.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: meterRecords.length,
            itemBuilder: ((context, index) {
              var meterReadingRecord =
                  meterRecords[meterRecords.length - index - 1];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 2.w),
                    tileColor: meterReadingRecord.uploadStatus == "No"
                        ? Colors.green[100]
                        : white,
                    onTap: () {
                      // if (DataConstants
                      //         .allEntriesControllerMobx.selectedConnections.length ==
                      //     1) {
                      //   Get.showSnackbar(errorSnackBar('You can select only one'));
                      // } else {
                      if (DataConstants
                          .allEntriesControllerMobx.selectedConnections
                          .contains(meterReadingRecord)) {
                        DataConstants.allEntriesControllerMobx
                            .removeSelectedRecord(meterReadingRecord);
                      } else {
                        DataConstants.allEntriesControllerMobx
                            .addSelectedRecord(meterReadingRecord);
                      }
                    },
                    leading: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierColor: Colors.black87,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        FlutterIcons.close_mco,
                                        color: Colors.red,
                                        size: 40.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CircleAvatar(
                                    radius: 45.w,
                                    backgroundImage: FileImage(
                                        File(meterReadingRecord.meterImage!)),
                                  )
                                ],
                              );
                            });
                      },
                      child: CircleAvatar(
                        radius: 7.w,
                        backgroundImage:
                            FileImage(File(meterReadingRecord.meterImage!)),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                          text: 'Consumer Number : ',
                          style: Controller.kwhiteSmallStyle(context, shade2),
                          children: [
                            TextSpan(
                                text: meterReadingRecord.barcode!.toString(),
                                style:
                                    Controller.kwhiteSmallStyle(context, black))
                          ]),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                          text: 'Meter Reading : ',
                          style: Controller.kwhiteSmallStyle(context, shade2),
                          children: [
                            TextSpan(
                                text:
                                    meterReadingRecord.meterReading!.toString(),
                                style:
                                    Controller.kwhiteSmallStyle(context, black))
                          ]),
                    ),
                    trailing: Observer(builder: (context) {
                      return DataConstants
                              .allEntriesControllerMobx.selectedConnections
                              .contains(meterReadingRecord)
                          ? const Icon(
                              Icons.check_circle,
                              color: primaryColor,
                            )
                          : const Icon(
                              Icons.check_circle_outline,
                              color: shade4,
                            );
                    })),
              );
            }))
        : Center(
            child: Text(
              'No Entries found!',
              style: Controller.kblackNormalStyle(context),
            ),
          );
  }

  void reloadEntry() async {
    DataConstants.allEntriesControllerMobx.reloadEntryLoader = true;
    List<Map<String, dynamic>> connections = <Map<String, dynamic>>[];
    // var data = Map<String, dynamic>.from(DataConstants
    //     .allEntriesControllerMobx.selectedConnections.first
    //     .toJson());
    // String scanDate =
    //     DateFormat('MM/dd/yyyy').format(DateTime.parse(data['scanDate']));
    // data.remove("scanDate");
    // data.remove("uploadStatus");
    // data.remove("meterImage");
    // data.remove("id");
    // data.addAll({"scanDate": scanDate});

    for (var element
        in DataConstants.allEntriesControllerMobx.selectedConnections) {
      String scanDate =
          DateFormat('MM/dd/yyyy').format(DateTime.parse(element.scanDate!));
      final Map<String, dynamic> data = {
        "deviceId": element.deviceId,
        "scanDate": scanDate,
        "meterReading": element.meterReading,
        "barcode": element.barcode,
        "miterNumber": element.miterNumber.toString(),
        "userID": element.userID,
        "branchID": element.branchID,
        "locationName": element.locationName,
        "imageBase64": element.imageBase64,
        "meterStatus": element.meterStatus,
        "latitude": element.latitude,
        "longitude": element.longitude,
      };

      connections.add(data);
    }
    // log(jsonEncode(connections));
    // return;
    Controller.getInternetStatus().then((value) async {
      if (value!) {
        var success = await DataConstants.mobxApiCalls.uploadBulkEntry(
            connections,
            DataConstants.allEntriesControllerMobx.selectedConnections,
            DataConstants.allEntriesControllerMobx.selectedStatus,
            isReload: true);

        if (success) {
          Get.showSnackbar(
              successSnackBar('Selected records has been uploaded'));
        }
      } else {
        Get.showSnackbar(errorSnackBar('No Internet Connection'));
        DataConstants.allEntriesControllerMobx.reloadEntryLoader = false;
      }
    });
  }

  void uploadEntry() async {
    DataConstants.allEntriesControllerMobx.uploadEntryLoader = true;
    setState(() {});
    meterRecords = await DataConstants.meterReadingControllerMobx
        .getLimitedMeterReadingsByStatus("No");
    List<Map<String, dynamic>> connections = <Map<String, dynamic>>[];
    // var data = Map<String, dynamic>.from(DataConstants
    //     .allEntriesControllerMobx.selectedConnections.first
    //     .toJson());
    // String scanDate =
    //     DateFormat('MM/dd/yyyy').format(DateTime.parse(data['scanDate']));
    // data.remove("scanDate");
    // data.remove("uploadStatus");
    // data.remove("meterImage");
    // data.remove("id");
    // data.addAll({"scanDate": scanDate});

    for (var element in meterRecords) {
      String scanDate =
          DateFormat('MM/dd/yyyy').format(DateTime.parse(element.scanDate!));
      final Map<String, dynamic> data = {
        "deviceId": element.deviceId,
        "scanDate": scanDate,
        "meterReading": element.meterReading,
        "barcode": element.barcode,
        "miterNumber": element.miterNumber.toString(),
        "userID": element.userID,
        "branchID": element.branchID,
        "locationName": element.locationName,
        "imageBase64": element.imageBase64,
        "meterStatus": element.meterStatus,
        "latitude": element.latitude,
        "longitude": element.longitude,
      };

      connections.add(data);
    }
    // log(jsonEncode(connections));
    // return;
    Controller.getInternetStatus().then((value) async {
      if (value!) {
        var success = await DataConstants.mobxApiCalls.uploadBulkEntry(
            connections,
            meterRecords,
            DataConstants.allEntriesControllerMobx.selectedStatus);

        if (success) {
          meterRecords.clear();
          await getNonUploadedRecords();
          if (meterRecords.isEmpty) {
            Get.showSnackbar(successSnackBar('All records has been uploaded'));
          } else {
            showNextBatchDialog(
                "Successful",
                "Upload Successfull, Continue with next batch",
                "Ok",
                "Next Batch");
          }
        }
      } else {
        Get.showSnackbar(errorSnackBar('No Internet Connection'));
      }
    });
  }

  void showNextBatchDialog(
      String title, String message, String btnText, String btn2Text) {
    // Get.defaultDialog(
    //   // navigatorKey: scaffoldState.currentWidget.,
    //   barrierDismissible: false,
    //   title: title,
    //   middleText: message,
    //   actions: <Widget>[
    //     TextButton(
    //       child: Text(btnText),
    //       onPressed: () {
    //         Navigator.pop(scaffoldState.currentContext!);
    //       },
    //     ),
    //     TextButton(
    //       child: Text(btn2Text),
    //       onPressed: () {
    //         Navigator.pop(scaffoldState.currentContext!);
    //         uploadEntry();
    //       },
    //     ),
    //   ],
    // );
    showDialog(
      context: scaffoldState.currentContext!,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(btnText),
              onPressed: () {
                Navigator.pop(scaffoldState.currentContext!);
              },
            ),
            TextButton(
              child: Text(btn2Text),
              onPressed: () {
                Navigator.pop(scaffoldState.currentContext!);
                uploadEntry();
              },
            ),
          ],
        );
      },
    );
  }
}
