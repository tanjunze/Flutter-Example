import 'package:flutter/material.dart';
import 'package:flutter_compt/assembly/loop_view.dart';
import 'package:flutter_compt/assembly/cache_image.dart';
import 'package:flutter_compt/model/data.dart';
import 'package:flutter_compt/utils/toast.dart';


/// 轮番图
class RollImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RollImageState();
  }
}

class _RollImageState extends State<RollImage> {
  int currentIndex=0;
  ///滚轮item
  Widget buildRollItem() {
    return LoopView<ImageBean>(
      datas: itemBeans,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      itemBuilder: (context, index) {
        currentIndex = index;
        return InkWell(
          onTap: () {
            showShortToast(itemBeans[index].name);
          },
          child: CacheLoadingImage(
            url: itemBeans[index].url,
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
                children:buildTextIndicator(itemBeans[currentIndex].name, itemBeans.length)
              ),
            )),
      ],
    );
  }
}
