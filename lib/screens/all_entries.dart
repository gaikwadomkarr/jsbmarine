import 'package:flutter/material.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/controller.dart';
import 'package:sizer/sizer.dart';

class AllEntries extends StatefulWidget {
  const AllEntries({ Key? key }) : super(key: key);

  @override
  State<AllEntries> createState() => _AllEntriesState();
}

class _AllEntriesState extends State<AllEntries> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: shade2,
            child: Column(
              children: [
                Text("Total Entries - 3", style: Controller.kwhiteSemiBoldNormalStyle(context, white),),
                SizedBox(height: 2.h,),
                Text("Remaining Entries - 3", style: Controller.kwhiteSemiBoldNormalStyle(context, white),),
              ],
            ),
          )
        ],
      )
    );
  }
}