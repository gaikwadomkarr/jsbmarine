import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/widgets/crop_widget.dart';
import 'package:sizer/sizer.dart';

class CamerWidget extends StatefulWidget {
  final String? imageName;
  const CamerWidget({Key? key, this.imageName}) : super(key: key);

  @override
  State<CamerWidget> createState() => _CamerWidgetState();
}

class _CamerWidgetState extends State<CamerWidget> {
  List<CameraDescription> cameras = [];
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  bool isCameraInitialized = false;
  bool isRearCameraSelected = true;
  double _value = 1.0;
  getCameraSettings() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      onNewCameraSelected(cameras[0]);
    } else {
      print("NO any camera found");
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = _controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        isCameraInitialized = _controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCameraSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 100.h,
        child: Column(
          // alignment: AlignmentDirectional.bottomCenter,
          children: [
            _controller == null
                ? const Center(child: Text("Loading Camera..."))
                : !isCameraInitialized
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox(
                        height: 85.h,
                        width: double.infinity,
                        child: _controller!.buildPreview(),
                      ),
            SizedBox(
              width: 75.w,
              child: Slider(
                value: _value,
                activeColor: CupertinoColors.activeGreen,
                inactiveColor: Colors.black26,
                thumbColor: shade2,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });

                  _controller!.setZoomLevel(value);
                },
                divisions: 10,
                min: 1,
                max: 10,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  InkWell(
                      onTap: () async {
                        HapticFeedback.heavyImpact();
                        Get.back();
                      },
                      child: Icon(
                        FlutterIcons.close_ant,
                        size: 30.sp,
                        color: Colors.red,
                      )),
                  InkWell(
                      onTap: () async {
                        HapticFeedback.heavyImpact();
                        print(
                            "take picture ${await _controller!.getMaxZoomLevel()} ${await _controller!.getMinZoomLevel()}");
                        // print(await _controller!.getMaxZoomLevel());
                        final imageFile = await _controller!.takePicture();
                        final file = File(imageFile.path);

                        Get.back(result: file);
                      },
                      child: Icon(
                        FlutterIcons.photo_camera_mdi,
                        size: 40.sp,
                      )),
                  InkWell(
                      onTap: () async {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          isCameraInitialized = false;
                        });
                        onNewCameraSelected(
                          cameras[!isRearCameraSelected ? 0 : 1],
                        );
                        setState(() {
                          isRearCameraSelected = !isRearCameraSelected;
                        });
                      },
                      child: Icon(
                        isRearCameraSelected
                            ? Icons.camera_front
                            : Icons.camera_rear,
                        size: 30.sp,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
