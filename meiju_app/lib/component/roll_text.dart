import 'package:flutter/material.dart';
import 'package:meiju_app/models/moive.dart';
import 'package:meiju_app/component/loop_view.dart';
import 'package:flutter/foundation.dart';

/// 滚轮文本
class RollText extends StatelessWidget {
  RollText({@required this.title,@required this.texts,this.onTap}) : assert(title != null),assert(texts!=null);
  final List<Moive> texts;
  final String title;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
            right: 10.0, left: 10.0, top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("$title ："),
          Expanded(
            child: LoopView<Moive>(
              datas: texts,
              duration: Duration(seconds: 2),
              scrollDirection: Axis.vertical,
              height: 30.0,
              itemBuilder: (context, index) {
                return new InkWell(
                  onTap:onTap,
                  child: new GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        /// 拦截垂直方向的手势
                      },
                      child: new Align(
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            "${texts[index].name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
