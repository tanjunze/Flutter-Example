import 'package:flutter/material.dart';
import 'package:meiju_app/component/detail_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:meiju_app/component/Poster.dart';
import 'package:meiju_app/component/rating_information.dart';
import 'package:meiju_app/data/data.dart';
import 'package:meiju_app/component/random_recommend.dart';
import 'package:meiju_app/models/moive.dart';

String imageUrl = "http://img.kukan5.com:808/pic/uploadimg/2016-11/19064.jpg";

class MoiveDetial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("相对宇宙第一季"),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xfff2f6f8),
        body: new SingleChildScrollView(child: new MovieDetailHeader()));
  }
}

class MovieDetailHeader extends StatelessWidget {
  String storyline =
      "JK Simmons主演的Starz科幻剧《相对宇宙 Counterpart》由Morten Tyldum当执行制片及执导首集，于15年时预订两季，每季10集。《相对宇宙》被形容为一部有抽象转折的间谍惊悚剧，讲述Howard Silk（JK Simmons饰）原本只是一政府机构的小角色，但发现原来局中是在守护一道能通往平行世界的「门」。而剧中通过他与平行世界的一个自己描述分括角色身份﹑假如事件﹑失落的爱等剧情。Olivia Williams饰演Emily Burton Silk，Howard的妻子，一位神秘的女性，是首季故事的中心；Harry Lloyd饰演Peter Quayle，是Howard所在机构的局长，他仔细地规划自己的职业生涯，但同时也身陷间谍世界和双重生活之中。Ulrich Thomsen將飾演Chekhov（代替演員Michael Nyqvist），Howard所在机构的行动部门主管，同时混和了哲学家和间谍的成份﹑Nazanin Boniadi饰演Clare，一个有神秘起源的年轻女子，她是驱动该季剧情发展的关键。Nicholas Pinnock饰演Ian Shaw，一个积极的操作员兼监视者，负责确保两个维度之间的平静﹑Sara Serraiocco饰演Baldwin，一个神秘的刺客，当她暴露在另一边世界时，有了新的目的。";
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeaderView(),
        _buildScoreView(),
        _buildMoreInfo(context),
        _buildRandomRecommend(),
      ],
    );
  }

  Widget _buildHeaderView() {
    return new Stack(
      children: <Widget>[
        new ArcBannerImage(imageUrl),
        new Positioned(
          top: 5.0,
          left: 16.0,
          right: 16.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Poster(
                imageUrl,
                height: 120.0,
              ),
              new Expanded(
                child: new Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 10.0, bottom: 16.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: new Text(
                            "Counterpart Season 1",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 17.0),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: new Text(
                            "魔幻/科幻",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: new Text(
                            "本季终 | 共10集",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: new Text(
                            "周一更新 已续订",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                        new Text(
                          "导演：Justin·Marks",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 15.0),
                        ),
                        // new RatingInformation(),
                      ],
                    )),
              ),
              //
            ],
          ),
        ),
      ],
    );
  }

  /// 评分
  Widget _buildScoreView() {
    return new Container(
        color: Colors.white,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    "评分：",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black),
                  ),
                  new RatingInformation(),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Text(
                storyline,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: new TextStyle(color: Colors.grey),
              ),
            )
          ],
        ));
  }

  Widget _buildMoreInfo(BuildContext context) {
    return new Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                child: _nameItem("导演", "莫滕·泰杜姆"),
              ),
              _nameItem("编剧", "Justin·Marks")
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: _nameItem("上映日期", "2018-01-21(美国)"),
              ),
              _nameItem("字幕组", "人人字幕组")
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: _nameItem("地区", "美国"),
              ),
              new Expanded(
                child: _nameItem("电视台", "Starz"),
              ),
              _nameItem("时长", "57分钟")
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: _nameItem("更新", "2018/4/1 22:42:22"),
              ),
              _nameItem("别名", "相对世界 / 副本")
            ],
          ),
          _nameItem("主演",
              "J·K·西蒙斯,奥莉维亚·威廉姆斯,乌尔里奇·汤姆森,纳赞宁·波妮阿蒂,尼古拉斯·平诺克,萨拉·萨里约科,米多·哈马达,肯尼斯·崔")
        ],
      ),
    );
  }

  Widget _nameItem(String name, String value) {
    return new RichText(
        text: new TextSpan(
      text: '$name：',
      style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      children: <TextSpan>[
        new TextSpan(
            text: value,
            style:
                new TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    ));
  }

  Widget _buildRandomRecommend() {
    return new Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Row(
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: new Icon(
                          Icons.whatshot,
                          color: Colors.red,
                        ),
                      ),
                      new Text(
                        "推荐",
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      )
                    ],
                  ),
                ),
                new InkWell(
                  onTap: () {},
                  child: new Row(
                    children: <Widget>[
                      new Text("换一换"),
                      new Icon(Icons.refresh)
                    ],
                  ),
                ),
              ],
            ),
          ),
          new RandomRecommend(
            moives: itemBeans,
          )
        ],
      ),
    );
  }
}

final itemBeans = <Moive>[
  new Moive(
      name: "此时此刻第一季",
      img: 'http://img.kukan5.com:808/pic/uploadimg/2018-2/5a81b6eeb9348.jpg'),
  new Moive(
      name: "高中卧底第一季",
      img:
          'http://img.kukan5.com:808/pic/uploadimg/2018-1/d813964dac7f640159c475447de2b1c8.jpg'),
  new Moive(
      name: "住院医师第一季",
      img: 'http://img.kukan5.com:808/pic/uploadimg/2018-1/p2506610722.jpg'),
//   new ImageBean(
//       name: "相对宇宙第一季",
//       url: 'http://img.kukan5.com:808/pic/uploadimg/2017-12/5a3212e3557f8.jpg'),
//   new ImageBean(
//       name: "仁医第一季",
//       url: 'http://img.kukan5.com:808/pic/uploadimg/2017-9/p2496064819.jpg'),
];
