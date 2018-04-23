import 'package:flutter/material.dart';
import 'package:meiju_app/component/LoopImage.dart';
import 'package:meiju_app/component/NotificationText.dart';
import 'package:meiju_app/repository/repository_factory.dart';
import 'package:meiju_app/models/moive.dart';
import 'home/HomeHorizontalSroll.dart';

// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  List<MoiveGroup> groups = <MoiveGroup>[];
  @override
  void initState() {
    super.initState();
    new RepositoryFactory()
        .getRecommendRepository()
        .findMoiveGroups()
        .then((groups) {
      _setDatas(groups);
    }).catchError((e) {
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("美剧"),
      ),
      backgroundColor: const Color(0xfff2f6f8),
      body: new ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context,index){
          return _buildGroup(context,index);
        },
      ),
    );
  }

  Widget _buildGroup(BuildContext context, int index) {
    if (index == 0) {
      //轮番图
      return new LoopImage(
        imagesBanner: groups[0].moives,
      );
    } else if (index == 1) {
      // 消息栏
      MoiveGroup moiveGroup = groups[1];
      return new NotificationText(
        imagesBanner: moiveGroup.moives,
        title: moiveGroup.title,
      );
    }
    // 分类item
    return new HomeHorizontalScroll(
        moiveGroup: groups[index], type: HomeHorizontalScrollType.other);
  }

  /// 更新数据¬
  _setDatas(List<MoiveGroup> mGroup) {
    setState(() {
      groups.addAll(mGroup);
    });
  }
}
