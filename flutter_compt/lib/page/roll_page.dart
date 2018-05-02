import 'package:flutter/material.dart';
import 'package:flutter_compt/assembly/roll_image.dart';
import 'package:flutter_compt/assembly/roll_text.dart';

class RollImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("滚轮小组件"),
      ),
      body: ListView(
        children: <Widget>[
           RollImage(),
           Divider(),
           RollText("最近更新"), 
           Divider(),
           new Text("TODO:1、视差效果")
        ],
      ),
    );
  }
}
