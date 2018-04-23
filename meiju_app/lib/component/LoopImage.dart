import 'package:flutter/material.dart';
import 'dart:async';
import 'package:meiju_app/models/moive.dart';
import 'package:meiju_app/component/cache_image.dart';
import 'package:meiju_app/page/routes/routes.dart';
/// 轮番图片
class LoopImage extends StatefulWidget {
  LoopImage({this.imagesBanner});
  List<Moive> imagesBanner;
  @override
  State<StatefulWidget> createState() {
    // print("LoopImage===createState");
    return new _LoopImage(imagesBanner: imagesBanner);
  }
}

class _LoopImage extends State<LoopImage> {
  _LoopImage({this.imagesBanner});
  bool isLoopPause = false;
  List<Moive> imagesBanner = <Moive>[];
  PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    isLoopPause = false;
    // print("_LoopImage==initState");
    super.initState();
    _pageController = new PageController(
        initialPage: imagesBanner.length * 2, keepPage: false);
    handleLoop();
  }

  @override
  Widget build(BuildContext context) {
    //  print("_LoopImage==build");
    return new Container(
      width: double.infinity,
      height: 200.0,
      child: new Stack(
        children: <Widget>[
          new NotificationListener(
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
            child: new PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index % imagesBanner.length;
                  });
                },
                controller: _pageController,
                itemBuilder: (context, index) {
                  Moive moiveBean =
                      imagesBanner[index % imagesBanner.length];
                  return new InkWell(
                    onTap: (){
                      openPage(context, moiveClassifyRoute);
                    },
                    child: new CacheLoadingImage(
                    url: moiveBean.img,
                  ),
                  ) ;//new Image.network(moiveBean.img, fit: BoxFit.cover);
                }),
          ),
          new Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black.withAlpha(100),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buildCircle(imagesBanner[currentIndex].name,
                    imagesBanner.length, currentIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleLoop() {
    new Timer.periodic(const Duration(seconds: 3), (_) {
      if (_pageController != null && !isLoopPause) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.decelerate);
      }
    });
  }

  List<Widget> _buildCircle(String name, int length, int currentIndex) {
    List<Widget> widgets = new List<Widget>.generate(length, (int index) {
      return new TabPageSelectorIndicator(
        backgroundColor: currentIndex == index ? Colors.white : Colors.grey,
        borderColor: currentIndex == index ? Colors.white : Colors.grey,
        size: 8.0,
      );
    }).toList();
    widgets.insert(
        0,
        new Expanded(
          child: new Text(
            name,
            style: new TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ));
    return widgets;
  }

  @override
  void dispose() {
    isLoopPause=true;
    // print("_LoopImage==dispose");
    super.dispose();
    _pageController.dispose();
  }
}

class TabPageSelectorIndicator extends StatelessWidget {
  const TabPageSelectorIndicator({
    Key key,
    this.backgroundColor,
    this.borderColor,
    this.size,
  })  : assert(backgroundColor != null),
        assert(borderColor != null),
        assert(size != null),
        super(key: key);

  final Color backgroundColor;

  final Color borderColor;

  final double size;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(4.0),
      decoration: new BoxDecoration(
        color: backgroundColor,
        border: new Border.all(color: borderColor),
        shape: BoxShape.circle,
      ),
    );
  }
}
