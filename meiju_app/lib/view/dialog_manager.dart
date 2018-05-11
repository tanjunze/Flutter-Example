import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DialogManager {
  ///选着颜色对话框
  static showColorPickerDialog(
      BuildContext context, ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: const Text('选择颜色'),
        content: new SingleChildScrollView(
          child: ColorPicker(
            pickerColor: Color(0xff443a49),
            onColorChanged: onColorChanged,
            colorPickerWidth: 1000.0,
            pickerAreaHeightPercent: 0.7,
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
