import 'package:flutter/material.dart';
import 'package:meiju_app/repository/repository_factory.dart';
import 'package:meiju_app/models/moive.dart';
import 'home/HomeHorizontalSroll.dart';
import 'package:meiju_app/component/roll_image.dart';
import 'package:meiju_app/component/roll_text.dart';
import 'routes/routes.dart';
import 'package:meiju_app/page/home/recent_updates_list.dart';
import 'package:meiju_app/util/global.dart';
import 'package:meiju_app/component/future_body_view.dart';
import 'dart:async';

// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  Future<List<MoiveGroup>> datasSource;
  List<MoiveGroup> groups;
  @override
  void initState() {
    super.initState();
    datasSource =
        RepositoryFactory().getRecommendRepository().findMoiveGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("美剧"),
      ),
      backgroundColor: pageColor,
      body: FutureBodyView<List<MoiveGroup>>(
        bodyBuilder: (datas) {
          groups = datas;
          return ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context, index) {
              return _buildGroup(context, index);
            },
          );
        },
        future: datasSource,
        onRetry: () {
          setState(() {
            datasSource =
                RepositoryFactory().getRecommendRepository().findMoiveGroups();
          });
        },
      ),
    );
  }

  Widget _buildGroup(BuildContext context, int index) {
    if (index == 0) {
      //轮番图
      return RollImage(
        onTap: () {
          openPage(context, moiveDetailRoute);
        },
        images: groups[0].moives,
      );
    } else if (index == 1) {
      // 消息栏
      MoiveGroup moiveGroup = groups[1];
      return RollText(
        texts: moiveGroup.moives,
        title: moiveGroup.title,
        onTap: () {
          showBottomList(context, moiveGroup.moives);
        },
      );
    }
    // 分类item
    return new HomeHorizontalScroll(
        moiveGroup: groups[index], type: HomeHorizontalScrollType.other);
  }
}
