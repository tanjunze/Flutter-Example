import 'package:flutter/material.dart';
import 'package:meiju_app/util/ImagePickerHelper.dart';
import 'dart:async';
import 'dart:io';

typedef void PickerImageLisenter(Future<File> file);

/// 选着拍照相册对话框
class PickerPhotoDialog extends StatelessWidget {
  PickerPhotoDialog(this.pickerLisenter);
  String itemTakePhoto = "拍照";
  String itemAlbum = "相册";
  String itemCancel = "取消";
  ImagePickerHelper pickerHelper;
  PickerImageLisenter pickerLisenter;
  @override
  Widget build(BuildContext context) {
    pickerHelper = new ImagePickerHelper(maxHeight: 160.0,maxWidth: 160.0);
    return new SafeArea(
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildItem(context, itemTakePhoto),
            _buildItem(context, itemAlbum),
            _buildItem(context, itemCancel),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String text) {
    return new InkWell(
      onTap: () {
        if (text == itemAlbum) {
          pickerHelper.pickerImage();
          if (pickerLisenter != null) {
            pickerLisenter(pickerHelper.imageFile);
          }
        } else if (text == itemTakePhoto) {
          pickerHelper.takePhoto();
          if (pickerLisenter != null) {
            pickerLisenter(pickerHelper.imageFile);
          }
        }
        Navigator.pop(context);
      },
      child: new Container(
        margin: const EdgeInsets.all(5.0),
        decoration: new BoxDecoration(
            color: Colors.red, borderRadius: new BorderRadius.circular(5.0)),
        width: double.infinity,
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
        child: new Center(
          child: new Text(text,
              textAlign: TextAlign.start,
              style: new TextStyle(color: Colors.white, fontSize: 16.0)),
        ),
      ),
    );
  }
}

showBottomDialog(BuildContext context,PickerImageLisenter pickerLisenter) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return new PickerPhotoDialog(pickerLisenter);
      });
}
