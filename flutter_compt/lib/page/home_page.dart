import 'package:flutter/material.dart';
import 'package:flutter_compt/page/routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("自定义小组件集合"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            onTap: () {
              openPage(context, LoopViewRoute);
            },
            title: new Text("轮番图小组件"),
          ),
          new ListTile(
            onTap: () {
              openPage(context, WheelViewRoute);
            },
            title: new Text("时间/地区选择器"),
          )
        ],
      ),
    );
  }
}
