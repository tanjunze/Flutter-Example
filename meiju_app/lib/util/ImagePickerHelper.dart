import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  Future<File> imageFile;
  
  ImagePickerHelper({this.maxHeight,this.maxWidth});
  double maxWidth;
  double maxHeight;

  pickerImage() {
    imageFile = ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: maxWidth,maxHeight: maxHeight);
  }

  takePhoto() {
    imageFile = ImagePicker.pickImage(source: ImageSource.camera,maxWidth: maxWidth,maxHeight: maxHeight);
  }
}
