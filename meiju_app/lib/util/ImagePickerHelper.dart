import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  Future<File> imageFile;
  pickerImage() {
    imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
  }

  takePhoto() {
    imageFile = ImagePicker.pickImage(source: ImageSource.camera);
  }
}
