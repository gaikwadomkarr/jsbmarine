import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> imageToFile(
      {ByteData? imageBytes, String? imageName, String? ext}) async {
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$imageName.$ext');
    await file.writeAsBytes(imageBytes!.buffer
        .asUint8List(imageBytes.offsetInBytes, imageBytes.lengthInBytes));
    return file;
  }
}
