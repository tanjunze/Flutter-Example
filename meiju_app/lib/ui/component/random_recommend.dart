import 'package:flutter/material.dart';
import 'package:meiju_app/data/bean/moive.dart';
import 'package:meiju_app/ui/component/cache_image.dart';

class RandomRecommend extends StatelessWidget {
  RandomRecommend({this.moives});
  List<Moive> moives;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: new List<Widget>.generate(moives.length, (int index) {
        Moive moive = moives[index];
        return _buildItem(context, moive);
      }),
    );
  }

  /// 推荐分组Item样式
  _buildItem(BuildContext context, Moive moive) {
    return new Expanded(
      child: new InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/moive_detail');
        },
        child: new Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: new Column(
            children: <Widget>[
              new ClipRRect(
                  borderRadius: new BorderRadius.circular(4.0),
                  child: new CacheLoadingImage(
                    height: 150.0,
                    width: 100.0,
                    url: moive.img,
                  )),
              new Text(moive.name,overflow: TextOverflow.clip,)
            ],
          ),
        ),
      ),
    );
  }
}
