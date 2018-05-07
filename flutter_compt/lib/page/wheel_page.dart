import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_compt/assembly/wheel_picker.dart';

const double _kPickerSheetHeight = 216.0;
const List<String> coolColorNames = const <String>[
  'Sarcoline',
  'Coquelicot',
  'Smaragdine',
  'Mikado',
  'Glaucous',
  'Wenge',
  'Fulvous',
  'Xanadu',
  'Falu',
  'Eburnean',
  'Amaranth',
  'Australien',
  'Banan',
  'Falu',
  'Gingerline',
  'Incarnadine',
  'Labrabor',
  'Nattier',
  'Pervenche',
  'Sinoper',
  'Verditer',
  'Watchet',
  'Zaffre',
];

class WheelPickerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WheelPickerState();
  }
}

class _WheelPickerState extends State<WheelPickerPage> {
  String color = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("滚轮"),
      ),
      body: ListView(
        children: <Widget>[
          new Text(color),
          RaisedButton(
            onPressed: () {
              showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) {
                  return showWheelDialog();
                },
              );
            },
            child: new Text("滚轮1"),
          )
        ],
      ),
    );
  }

  showWheelDialog() {
    return new SizedBox(
      height: _kPickerSheetHeight,
      child: new DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: new GestureDetector(
          onTap: () {},
          child: new ValuePicker(
            values: coolColorNames,
            onSelectedItemChanged: (int index) {
              setState(() {
                color = coolColorNames[index];
              });
            },
          ),
        ),
      ),
    );
  }
  /// 年月日
}
