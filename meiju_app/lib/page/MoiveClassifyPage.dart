import 'package:flutter/material.dart';
import 'package:meiju_app/util/global.dart';
import 'package:meiju_app/component/expand_view.dart';
import 'package:meiju_app/component/mult_select_tabs.dart';
import 'classify/classify_drawer.dart';

/// 电影分类页面
class MoiveClassifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MoiveClassify();
  }
}

class _MoiveClassify extends State<MoiveClassifyPage>
    with SingleTickerProviderStateMixin {
  ExpandController controller;
  MultSelectTabController tabController;
  @override
  void initState() {
    super.initState();
    controller = new ExpandController();
    tabController = new MultSelectTabController();
    controller.setExpandStateLisenter((isOpen) {
      tabController.setCurrentIndex(isOpen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("索引"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      endDrawer: new ClassifyDrawer(),
      backgroundColor: pageColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new Column(children: <Widget>[
      new MultSelectTabs(
        onTabTaps: (index, state) {
          controller.expand(state);
        },
        controller: tabController,
        tabItems: <MultSelectItem>[
          new MultSelectItem(name: "选择1"),
          new MultSelectItem(name: "选择2"),
          new MultSelectItem(name: "选择3"),
        ],
      ),
      new ExpandViewWidget(
        expandController: controller,
        child: new ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              if (index.isOdd) {
                return new Divider();
              }
              return new Container(
                height: 40.0,
                width: double.infinity,
                color: Colors.brown,
              );
            }),
        expandChild: new ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) {
            return new Divider();
          }
          return new Container(
            height: 40.0,
            width: double.infinity,
            color: Colors.lightBlue,
          );
        }),
      )
    ]);
  }
}
