import 'package:flutter/material.dart';
import 'package:meiju_app/models/moive.dart';
import 'package:meiju_app/component/cache_image.dart';
/// 水平滚动类型
enum HomeHorizontalScrollType {
  /// 推荐类型
  recommend,

  /// 其他类型
  other,
}
/// 水平滚动类型组件
class HomeHorizontalScroll extends StatelessWidget {
  HomeHorizontalScroll({
    this.moiveGroup,
    this.type
  });

  final MoiveGroup moiveGroup;
  final HomeHorizontalScrollType type;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return new Container(
      color: Colors.white,
      margin:const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(bottom: 10.0),
      child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: new Row(children: <Widget>[new Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: new Icon(Icons.whatshot,color: Colors.red,),
          ),new Text(
            moiveGroup.title,
            style: textTheme.subhead.copyWith(fontSize: 16.0),
          )],),
        ),
       _buildRecommendGroup()
      ],
    ),
    );
  }
  /// 推荐分组样式
  _buildRecommendGroup(){
    return  new SizedBox.fromSize(
          size:const Size.fromHeight(150.0),
          child: new ListView.builder(
            itemCount: moiveGroup.moives.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10.0),
            itemBuilder: (context,index){
              return _buildRecommendGroupItem(context,index);
            },
          ),
        );
  }
  /// 推荐分组Item样式
  _buildRecommendGroupItem(BuildContext context, int index){
    Moive moive=moiveGroup.moives[index];
    return new InkWell(
      onTap: (){
          Navigator.pushNamed(context, '/moive_detail');
      },
      child: new Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: new ClipRRect(
        borderRadius: new BorderRadius.circular(4.0),
        child:new CacheLoadingImage(
            height: 150.0,
            width: 100.0,
            url: moive.img,
          )),
    ),
    );
  }
}
