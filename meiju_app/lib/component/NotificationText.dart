import 'package:flutter/material.dart';
import 'package:meiju_app/models/moive.dart';
import 'dart:async';
import 'package:meiju_app/component/cache_image.dart';

class NotificationText extends StatefulWidget {
  NotificationText({this.imagesBanner, this.title});
  final String title;
  final List<Moive> imagesBanner;
  @override
  State<StatefulWidget> createState() {
    return new _NotificationTextState(imagesBanner: imagesBanner, title: title);
  }
}

class _NotificationTextState extends State<NotificationText> {
  _NotificationTextState({this.imagesBanner, this.title});
  bool isLoopPause = false;
  String title;
  List<Moive> imagesBanner;
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
    return new InkWell(
      onTap: () {
        _buildBottomDialog(context);
      },
      child: new Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
            right: 10.0, left: 10.0, top: 5.0, bottom: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("$title ："),
            new Expanded(
                child: new NotificationListener(
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
                    child: new SizedBox.fromSize(
                      size: const Size.fromHeight(30.0),
                      child: new PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          Moive moiveBean =
                              imagesBanner[index % imagesBanner.length];
                          return new Align(
                            alignment: Alignment.centerLeft,
                            child: new Text(
                              "${moiveBean.name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          );
                        },
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  /// 显示底部对话框
  _buildBottomDialog(BuildContext context) {
    Iterable<Widget> listTiles =
        new Iterable<Widget>.generate(imagesBanner.length, (int index) {
      return _buildBottomDialogItme(context, index);
    });
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new GestureDetector(
            onTap: () {},
            child: new Column(
              children: <Widget>[
                new Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: new Text("最近更新",
                      textAlign: TextAlign.start,
                      style:
                          new TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
                new Divider(
                  height: 2.0,
                ),
                new Expanded(
                  child: new ListView(
                    padding: new EdgeInsets.symmetric(vertical: 2.0),
                    children: listTiles.toList(),
                  ),
                )
              ],
            ),
          );
        });
  }

  _buildBottomDialogItme(context, index) {
    Moive moive = imagesBanner[index];
    if (index == 0) {
      return new ListTile(
          onTap: () {},
          title: new Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: new Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: new CacheLoadingImage(
                    url: moive.img,
                    height: 110.0,
                    width: 80.0,
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding:const EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child: new Text(
                      "${moive.name}",
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    ),
                    new Text(
                      "${moive.type}",
                      style: new TextStyle(fontSize: 13.0),
                    ),
                    new Text(
                      "第9集",
                      style: new TextStyle(fontSize: 13.0),
                    ),
                    new Text(
                      "已更新",
                      style: new TextStyle(fontSize: 13.0),
                    ),
                  ],
                )
              ],
            ),
          ));
    }
    return new ListTile(
      onTap: () {},
      title: new Text("${moive.name}"),
    );
  }

  void handleLoop() {
    new Timer.periodic(const Duration(seconds: 2), (_) {
      if (_pageController != null && !isLoopPause) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate);
      }
    });
  }

  @override
  void dispose() {
    isLoopPause = true;
    // print("_LoopImage==dispose");
    super.dispose();
    _pageController.dispose();
  }
}
