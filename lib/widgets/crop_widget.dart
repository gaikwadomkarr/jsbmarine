import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:crop/crop.dart';
import 'package:get/get.dart';
import 'package:jsbmarineversion1/utils/centered_slider_track_shape.dart';
import 'package:jsbmarineversion1/utils/color_constants.dart';
import 'package:jsbmarineversion1/utils/image_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class CropWidget extends StatefulWidget {
  final File? image;
  final String? imageName;

  const CropWidget({Key? key, this.image, this.imageName}) : super(key: key);
  @override
  _CropWidgetState createState() => _CropWidgetState();
}

class _CropWidgetState extends State<CropWidget> {
  final controller = CropController(aspectRatio: 1);
  double _rotation = 0;
  BoxShape shape = BoxShape.circle;

  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cropped = await controller.crop(pixelRatio: pixelRatio);
    var byteData = await cropped.toByteData(format: ui.ImageByteFormat.png);
    final file = await ImageUtils.imageToFile(
        imageBytes: byteData, imageName: widget.imageName!, ext: 'jpg');
    Get.back(result: file);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crop Demo'),
          backgroundColor: primaryColor,
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: _cropImage,
              tooltip: 'Crop',
              icon: const Icon(Icons.check),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8),
                child: Crop(
                  onChanged: (decomposition) {
                    if (_rotation != decomposition.rotation) {
                      setState(() {
                        _rotation =
                            ((decomposition.rotation + 180) % 360) - 180;
                      });
                    }

                    // print(
                    //     "Scale : ${decomposition.scale}, Rotation: ${decomposition.rotation}, translation: ${decomposition.translation}");
                  },
                  controller: controller,
                  shape: shape,
                  child: Image.file(
                    widget.image!,
                    fit: BoxFit.cover,
                  ),
                  /* It's very important to set `fit: BoxFit.cover`.
                     Do NOT remove this line.
                     There are a lot of issues on github repo by people who remove this line and their image is not shown correctly.
                  */
                  foreground: IgnorePointer(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        'Foreground Object',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  helper: shape == BoxShape.rectangle
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.undo),
                  tooltip: 'Undo',
                  onPressed: () {
                    controller.rotation = 0;
                    controller.scale = 1;
                    controller.offset = Offset.zero;
                    setState(() {
                      _rotation = 0;
                    });
                  },
                ),
                Expanded(
                  child: SliderTheme(
                    data: theme.sliderTheme.copyWith(
                      trackShape: CenteredRectangularSliderTrackShape(),
                    ),
                    child: Slider(
                      divisions: 360,
                      value: _rotation,
                      min: -180,
                      max: 180,
                      label: '$_rotation°',
                      onChanged: (n) {
                        setState(() {
                          _rotation = n.roundToDouble();
                          controller.rotation = _rotation;
                        });
                      },
                    ),
                  ),
                ),
                PopupMenuButton<BoxShape>(
                  icon: const Icon(Icons.crop_free),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Box"),
                      value: BoxShape.rectangle,
                    ),
                    const PopupMenuItem(
                      child: Text("Oval"),
                      value: BoxShape.circle,
                    ),
                  ],
                  tooltip: 'Crop Shape',
                  onSelected: (x) {
                    setState(() {
                      shape = x;
                    });
                  },
                ),
                PopupMenuButton<double>(
                  icon: const Icon(Icons.aspect_ratio),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Original"),
                      value: 1000 / 667.0,
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      child: Text("16:9"),
                      value: 16.0 / 9.0,
                    ),
                    const PopupMenuItem(
                      child: Text("4:3"),
                      value: 4.0 / 3.0,
                    ),
                    const PopupMenuItem(
                      child: Text("1:1"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("3:4"),
                      value: 3.0 / 4.0,
                    ),
                    const PopupMenuItem(
                      child: Text("9:16"),
                      value: 9.0 / 16.0,
                    ),
                  ],
                  tooltip: 'Aspect Ratio',
                  onSelected: (x) {
                    controller.aspectRatio = x;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
