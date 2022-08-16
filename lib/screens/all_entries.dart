import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jsbmarineversion1/models/meter_reading_db_model.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
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
    setState(() {
      DataConstants.allEntriesControllerMobx.allConnectionsLoader = true;
    });
    DataConstants.allEntriesControllerMobx.allconnections.clear();
    var allconnections =
        await DataConstants.meterReadingControllerMobx.getConnections();
    DataConstants.allEntriesControllerMobx.updateAllConnections(allconnections);
    setState(() {
      DataConstants.allEntriesControllerMobx.allConnectionsLoader = false;
    });
    log(allconnections.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
                  buildMeterStatusFilter()
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
                if (index == 0) {
                  DataConstants.allEntriesControllerMobx.allconnections =
                      await DataConstants.meterReadingControllerMobx
                          .getConnections();
                } else {
                  DataConstants.allEntriesControllerMobx.allconnections =
                      await DataConstants.meterReadingControllerMobx
                          .getAllMeterReadingsByMeterStatus(index);
                }
                setState(() {});
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
}
