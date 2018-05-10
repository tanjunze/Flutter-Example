import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

typedef Widget ItemBuilder(BuildContext context, int index);

///循环view
class LoopView<T> extends StatefulWidget {
  LoopView({
    @required this.datas,
    @required this.itemBuilder,
    this.width: double.infinity,
    this.height: 200.0,
    this.duration: const Duration(seconds: 3),
    this.scrollDirection: Axis.horizontal,
    this.onPageChanged,
  })  : assert(datas != null),
        assert(itemBuilder != null);
  final List<T> datas;
  final double width;
  final double height;
  final ItemBuilder itemBuilder;
  final ValueChanged<int> onPageChanged;

  /// 滚动方向
  final Axis scrollDirection;

  /// 播放间隔
  final Duration duration;
  @override
  State<StatefulWidget> createState() {
    return _LoopViewState();
  }
}

class _LoopViewState extends State<LoopView> {
  bool isLoopPause = false;
  PageController controller;
  @override
  void initState() {
    isLoopPause = false;
    super.initState();
    controller =
        PageController(initialPage: widget.datas.length * 2, keepPage: false);
    _handleLoop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(widget.width, widget.height),
      child: NotificationListener(
        onNotification: (Notification note) {
          if (note is ScrollEndNotification) {
            isLoopPause = false;
          } else if (note is ScrollStartNotification) {
            isLoopPause = true;
          } else if (note is ScrollUpdateNotification) {
            isLoopPause = true;
          }
          return true;
        },
        child: PageView.builder(
            scrollDirection: widget.scrollDirection,
            controller: controller,
            onPageChanged: (int index) {
              if (widget.onPageChanged != null)
                widget.onPageChanged(index % widget.datas.length);
            },
            itemBuilder: (context, index) {
              int realIndex = index % widget.datas.length;
              return widget.itemBuilder(context, realIndex);
            }),
      ),
    );
  }

  /// 处理循环动画
  _handleLoop() {
    Timer.periodic(widget.duration, (_) {
      if (controller != null && !isLoopPause) {
        controller.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.decelerate);
      }
    });
  }

  @override
  void dispose() {
    isLoopPause = true;
    super.dispose();
    controller.dispose();
  }
}
