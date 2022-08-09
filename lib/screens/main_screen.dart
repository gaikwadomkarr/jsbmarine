import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:jsbmarineversion1/screens/new_reading.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:jsbmarineversion1/utils/data_constants.dart';
import 'package:jsbmarineversion1/utils/save_local_storage.dart';
import 'package:jsbmarineversion1/utils/string_constant.dart';
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
    Container(
      color: Colors.red,
    ),
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
            appBarPadding: const EdgeInsets.symmetric(vertical: 0),
            title: Text(
              DataConstants.homePageController.homePageTitle,
              style:
                  Controller.kblackNormalStyle(context).copyWith(color: white),
            ),
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
