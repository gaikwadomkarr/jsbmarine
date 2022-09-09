import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:sizer/sizer.dart';

class CamerWidget extends StatefulWidget {
  const CamerWidget({Key? key}) : super(key: key);

  @override
  State<CamerWidget> createState() => _CamerWidgetState();
}

class _CamerWidgetState extends State<CamerWidget> {
  List<CameraDescription> cameras = [];
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  double _value = 1.0;
  getCameraSettings() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras[0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      _controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
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
    return Container(
      height: 90.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controller == null
              ? Center(child: Text("Loading Camera..."))
              : !_controller!.value.isInitialized
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: 70.h,
                      width: 100.w,
                      child: CameraPreview(_controller!)),
          InkWell(
              onTap: () async {
                HapticFeedback.heavyImpact();
                print(
                    "take picture ${await _controller!.getMaxZoomLevel()} ${await _controller!.getMinZoomLevel()}");
                // print(await _controller!.getMaxZoomLevel());
                _controller!.setZoomLevel(5);
              },
              child: Icon(
                FlutterIcons.circle_double_mco,
                size: 10.h,
              )),
          CupertinoSlider(
            value: _value,
            activeColor: CupertinoColors.activeGreen,
            thumbColor: CupertinoColors.systemPink,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
              _controller!.setZoomLevel(value);
            },
            divisions: 10,
            min: 1,
            max: 10,
          )
        ],
      ),
    );
  }
}
