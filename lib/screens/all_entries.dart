import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
import 'package:jsbmarineversion1/widgets/c_gradient_button.dart';
import 'package:sizer/sizer.dart';

class AllEntries extends StatefulWidget {
  const AllEntries({Key? key}) : super(key: key);

  @override
  State<AllEntries> createState() => _AllEntriesState();
}

class _AllEntriesState extends State<AllEntries> {
  int selectedStatus = 0;

  @override
  void initState() {
    super.initState();
    getConnections();
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
    log(allconnections.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: shade4,
      body: Observer(builder: (context) {
        return DataConstants.allEntriesControllerMobx.allConnectionsLoader
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 4,
                ),
              )
            : Column(
                children: [
                  Container(
                    color: shade2,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Entries - ${DataConstants.allEntriesControllerMobx.allconnections.length}",
                          style: Controller.kwhiteSemiBoldNormalStyle(
                              context, white),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Remaining Entries - ${DataConstants.allEntriesControllerMobx.allconnections.length}",
                          style: Controller.kwhiteSemiBoldNormalStyle(
                              context, white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  buildMeterStatusFilter(),
                  SizedBox(
                    height: 2.h,
                  ),
                  DataConstants.allEntriesControllerMobx.allConnectionsLoader
                      ? const CircularProgressIndicator()
                      : buildMeterRecord(),
                  Observer(builder: (context) {
                    return DataConstants.allEntriesControllerMobx
                            .selectedConnections.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CGradientButton(
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
                                            uploadEntry();
                                          },
                                    color: primaryColor,
                                    icon: DataConstants.allEntriesControllerMobx
                                            .uploadEntryLoader
                                        ? const CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: primaryColor,
                                          )
                                        : null),
                                CGradientButton(
                                  buttonName: 'Delete',
                                  onPress: () async {
                                    var success = await DataConstants
                                        .meterReadingControllerMobx
                                        .deleteMeterReading(
                                            DataConstants
                                                .allEntriesControllerMobx
                                                .selectedConnections
                                                .first
                                                .id!,
                                            selectedStatus);
                                    if (success) {
                                      DataConstants.allEntriesControllerMobx
                                          .removeSelectedRecord(DataConstants
                                              .allEntriesControllerMobx
                                              .selectedConnections
                                              .first);
                                      Get.showSnackbar(successSnackBar(
                                          'Record deleted successfully'));
                                    } else {
                                      // Get.showSnackbar(errorSnackBar(
                                      //     'Failed. Please try again later'));
                                    }
                                  },
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
                  SizedBox(
                    height: 1.h,
                  )
                ],
              );
      }),
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
            return GestureDetector(
              onTap: () async {
                setState(() {
                  selectedStatus = int.parse(allmeterStatusNoList[index]);
                });
                log(selectedStatus.toString());
                DataConstants.allEntriesControllerMobx.emptyselectedRecord();
                if (index == 0) {
                  DataConstants.allEntriesControllerMobx.getallconnections();
                } else {
                  DataConstants.allEntriesControllerMobx
                      .getstatuswiseconnections(index);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                margin: EdgeInsets.only(right: 2.w),
                decoration: BoxDecoration(
                  color: selectedStatus == index ? primaryColor : grey,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                alignment: Alignment.center,
                child: Text(
                  allmeterStatusList[index],
                  style: Controller.kwhiteSmallStyle(context, white),
                ),
              ),
            );
          })),
    );
  }

  Widget buildMeterRecord() {
    return Observer(builder: (context) {
      return Expanded(
        child: DataConstants.allEntriesControllerMobx.allconnections.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: DataConstants
                    .allEntriesControllerMobx.allconnections.length,
                itemBuilder: ((context, index) {
                  var meterReadingRecord = DataConstants
                      .allEntriesControllerMobx.allconnections[index];
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0.h, horizontal: 2.w),
                        tileColor: white,
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
                                .emptyselectedRecord();
                            DataConstants.allEntriesControllerMobx
                                .addSelectedRecord(meterReadingRecord);
                          }
                        },
                        leading: CircleAvatar(
                          radius: 7.w,
                          backgroundImage:
                              FileImage(File(meterReadingRecord.meterImage!)),
                        ),
                        title: RichText(
                          text: TextSpan(
                              text: 'Consumer Number : ',
                              style:
                                  Controller.kwhiteSmallStyle(context, shade2),
                              children: [
                                TextSpan(
                                    text:
                                        meterReadingRecord.barcode!.toString(),
                                    style: Controller.kwhiteSmallStyle(
                                        context, black))
                              ]),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                              text: 'Meter Reading : ',
                              style:
                                  Controller.kwhiteSmallStyle(context, shade2),
                              children: [
                                TextSpan(
                                    text: meterReadingRecord.meterReading!
                                        .toString(),
                                    style: Controller.kwhiteSmallStyle(
                                        context, black))
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
              ),
      );
    });
  }

  void uploadEntry() async {
    var data = Map<String, dynamic>.from(DataConstants
        .allEntriesControllerMobx.selectedConnections.first
        .toJson());
    DateTime scanDate = DateTime.parse(data['scanDate']);
    // data.remove("scanDate");
    data.remove("uploadStatus");
    data.remove("meterImage");
    data.remove("id");
    // data.addAll({"scanDate": scanDate});
    log(data.toString());
    // return;
    Controller.getInternetStatus().then((value) async {
      if (value!) {
        DataConstants.mobxApiCalls.uploadEntry(data);
      } else {
        Get.showSnackbar(errorSnackBar('No Internet Connection'));
      }
    });
  }
}
