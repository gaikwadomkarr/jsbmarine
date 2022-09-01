import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/screens/all_entries.dart';
import 'package:jsbmarineversion1/screens/new_reading.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/save_local_storage.dart';
import 'package:jsbmarineversion1/utils/snackbars.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
import 'package:jsbmarineversion1/widgets/c_gradient_button.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  var childrens = [
    NewReadingPage(),
    AllEntries(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SliderDrawer(
          key: _key,
          appBar: SliderAppBar(
            appBarHeight: 7.h,
            appBarColor: primaryColor,
            drawerIconColor: white,
            isTitleCenter: true,
            appBarPadding: EdgeInsets.symmetric(vertical: 0.w),
            title: Text(
              DataConstants.homePageController.homePageTitle,
              style:
                  Controller.kblackNormalStyle(context).copyWith(color: white),
            ),
            trailing: DataConstants.currentPage == 1
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (DataConstants.allEntriesControllerMobx
                              .selectedConnections.isEmpty) {
                            Get.showSnackbar(
                                errorSnackBar('Please select records first'));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: white,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'CONFIRM',
                                      style: Controller.buttonText(context),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        FlutterIcons.close_mco,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                content: Text(
                                  'Selected records will be deleted forever.',
                                  style:
                                      Controller.kblackSemiNormalStyle(context),
                                ),
                                actions: [
                                  CGradientButton(
                                    buttonName: 'Cancel',
                                    onPress: () => Navigator.pop(context),
                                    color: shade3,
                                  ),
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
                                              0);
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
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                              ),
                              barrierDismissible: false,
                            );
                          }
                        },
                        child: Icon(
                          FlutterIcons.delete_mdi,
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      )
                    ],
                  )
                : null,
          ),
          slider: Container(
            color: shade3,
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: black,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            DataConstants.homePageController.homePageTitle =
                                newReading;
                            DataConstants.currentPage = 0;
                          });
                          _key.currentState!.closeSlider();
                        },
                        icon: Icon(
                          Icons.add_circle_outline_rounded,
                          color: black,
                          size: 25.sp,
                        ),
                        label: Text(
                          newReading,
                          style: Controller.kwhiteSemiBoldNormalStyle(
                              context, black),
                        )),
                  ),
                  const Divider(
                    color: black,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            DataConstants.homePageController.homePageTitle =
                                allEntries;
                            DataConstants.currentPage = 1;
                          });
                          _key.currentState!.closeSlider();
                        },
                        icon: Icon(
                          Icons.list_alt_rounded,
                          color: black,
                          size: 25.sp,
                        ),
                        label: Text(
                          allEntries,
                          style: Controller.kwhiteSemiBoldNormalStyle(
                              context, black),
                        )),
                  ),
                  const Divider(
                    color: black,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () {
                          Preferences.clearCache();
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: black,
                          size: 25.sp,
                        ),
                        label: Text(
                          logout,
                          style: Controller.kwhiteSemiBoldNormalStyle(
                              context, black),
                        )),
                  ),
                  const Divider(
                    color: black,
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            height: 90.h,
            color: shade4,
            child: childrens[DataConstants.currentPage],
          ),
        ),
      ),
    );
  }
}
