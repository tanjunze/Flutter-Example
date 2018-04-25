import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:meiju_app/util/CameraHelper.dart';

class TakePhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TakePhotoPageState();
  }
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  String imagePath;
  CameraHelper cameraHelper;
  @override
  void initState() {
    super.initState();
    cameraHelper = new CameraHelper(context);
    cameraHelper.initCamera().then((success) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    if (cameraHelper.controller != null) {
      widgets.add( new AspectRatio(
          aspectRatio: cameraHelper.controller.value.aspectRatio,
          child: new CameraPreview(cameraHelper.controller),
        ));
    }
    widgets.add(new Positioned(
      left: 10.0,
      right: 10.0,
      bottom: 30.0,
      child: new Center(
        child: new FloatingActionButton(
          onPressed: (){
            cameraHelper.capture()
            .then((path){
              print("object==$path");
            });
          },
          child: const Icon(
            Icons.camera,
          ),
        )
      ),
    ));
    widgets.add(new Positioned(
      right: 30.0,
      bottom: 40.0,
      child: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
    ));
    return new Stack(
      children: widgets,
    );
  }

  @override
  void dispose() {
    cameraHelper.dispose();
    super.dispose();
  }
}
