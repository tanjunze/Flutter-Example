import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ValuePicker extends StatefulWidget {
  ValuePicker({this.values, this.pickerItemHeight: 32.0,this.onSelectedItemChanged})
      : assert(values != null);
  final List<String> values;
  final double pickerItemHeight;
  final ValueChanged<int> onSelectedItemChanged;
  @override
  State<StatefulWidget> createState() {
    return _ValuePickerState();
  }
}

class _ValuePickerState extends State<ValuePicker> {
  int _selectedItemIndex = 0;
  FixedExtentScrollController scrollController;
  @override
  void initState() {
    scrollController =
        new FixedExtentScrollController(initialItem: _selectedItemIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoPicker(
      scrollController: scrollController,
      itemExtent: widget.pickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) {
        // setState(() {
          _selectedItemIndex = index;
        // });
        if (widget.onSelectedItemChanged != null) {
          widget.onSelectedItemChanged(index);
        }
      },
      children: new List<Widget>.generate(widget.values.length, (int index) {
        return new Center(
          child: new Text(widget.values[index]),
        );
      }),
    );
  }
}
