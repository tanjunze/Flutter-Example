import 'package:flutter/material.dart';
import 'package:meiju_app/data/bean/moive.dart';
import 'package:meiju_app/view/component/cache_image.dart';
import 'package:meiju_app/view/component/loop_view.dart';
import 'package:flutter/foundation.dart';

/// 轮番图
class RollImage extends StatefulWidget {
  RollImage({@required this.images, this.onTap}) : assert(images != null);
  final List<Moive> images;
  GestureTapCallback onTap;

  @override
  State<StatefulWidget> createState() {
    return _RollImageState();
  }
}

class _RollImageState extends State<RollImage> {
  int currentIndex = 0;

  ///滚轮item
  Widget buildRollItem() {
    return LoopView<Moive>(
      datas: widget.images,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        currentIndex = index;
        return InkWell(
          onTap: widget.onTap,
          child: CacheLoadingImage(
            url: widget.images[index].img,
          ),
        );
      },
    );
  }

  /// 滚轮指示器
  List<Widget> buildTextIndicator(String text, int length) {
    List<Widget> indicators = new List<Widget>.generate(length, (int index) {
      return new TabPageSelectorIndicator(
        backgroundColor: currentIndex == index ? Colors.white : Colors.grey,
        borderColor: currentIndex == index ? Colors.white : Colors.grey,
        size: 6.0,
      );
    }).toList();
    indicators.insert(
        0,
        new Expanded(
          child: new Text(
            text,
            style: new TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ));
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildRollItem(),
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black.withAlpha(100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: buildTextIndicator(
                      widget.images[currentIndex].name, widget.images.length)),
            )),
      ],
    );
  }
}
