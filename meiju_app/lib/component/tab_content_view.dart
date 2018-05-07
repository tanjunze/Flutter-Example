import 'package:flutter/material.dart';

/// tab 保存状态View
class TabContentView extends StatelessWidget {
  TabContentView({this.contents, this.currentIndex: 0})
      : assert(contents != null);
  final List<Widget> contents;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(contents.length, (index) {
        final bool active = currentIndex == index;
        return Offstage(
            offstage: !active,
            child: TickerMode(
              enabled: active,
              child: contents[index],
            ));
      }),
    );
  }
}
