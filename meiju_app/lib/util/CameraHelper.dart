import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class CameraHelper {
  List<CameraDescription> cameras;
  CameraController controller;
  BuildContext context;
  CameraHelper(this.context);
  /// 分辨率
  ResolutionPreset resolution;

  /// 初始化 摄像头
  Future<bool> initCamera() async {
    cameras = await availableCameras();
    return await openCamera();
  }

  /// 打开摄像头
  Future<bool> openCamera({CameraDescription description}) async {
    if (cameras != null && cameras.length > 0) {
      final CameraController tempController = controller;
      controller = null;
      await tempController?.dispose();
      controller = new CameraController(
          description != null ? description : cameras[0],
          ResolutionPreset.high);
      await controller.initialize();
      return true;
    }
    return false;
  }

  /// 拍照并保存在临时目录
  Future<String> capture() async {
    if (controller.value.isStarted) {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      int time =new DateTime.now().millisecondsSinceEpoch;
      final String path = '$tempPath/img_$time.jpg';
      await controller.capture(path);
      return path;
    }
    throw new Exception("相机没有开始");
  }

  /// 播放暂停相机
  playPauseCamera() {
    if (controller.value.isStarted) {
      controller.stop();
    } else {
      controller.start();
    }
  }

  dispose() {
    controller?.dispose();
  }
}

//  new AspectRatio(
//           aspectRatio: cameraHelper.controller.value.aspectRatio,
//           child: new CameraPreview(cameraHelper.controller),
//         )
