import 'package:flutter/material.dart';
import 'package:meiju_app/ui/component/cache_image.dart';
import 'package:meiju_app/data/bean/moive.dart';

/// 显示底部 最近更新
showBottomList(BuildContext context, List<Moive> moives) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return new GestureDetector(
          onTap: () {
            /// 拦截关闭事件
          },
          child: RecentUpdatesList(moives: moives),
        );
      });
}

/// 最近更新列表
class RecentUpdatesList extends StatelessWidget {
  RecentUpdatesList({this.moives}) : assert(moives != null);
  final List<Moive> moives;
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
          child: new Text("最近更新",
              textAlign: TextAlign.start,
              style: new TextStyle(color: Colors.black, fontSize: 16.0)),
        ),
        new Divider(
          height: 2.0,
        ),
        new Expanded(
          child: new ListView(
            padding: new EdgeInsets.symmetric(vertical: 2.0),
            children: _buildListWidget(context),
          ),
        )
      ],
    );
  }

  _buildListWidget(BuildContext context) {
    Iterable<Widget> listTiles =
        new Iterable<Widget>.generate(moives.length, (int index) {
      return _buildListItme(context, index);
    });
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return listTiles.toList();
  }

  _buildListItme(context, index) {
    Moive moive = moives[index];
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
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
}
