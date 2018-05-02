import 'package:flutter/material.dart';
import 'package:flutter_compt/assembly/loop_view.dart';
import 'package:flutter_compt/model/data.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 滚轮文本
class RollText extends StatelessWidget {
  RollText(this.title) : assert(title != null);
  String title;
  @override
  Widget build(BuildContext context) {
    return
     Padding(
       padding: const EdgeInsets.only(left: 10.0,right: 10.0),
       child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("$title ："),
        Expanded(
          child: LoopView<ImageBean>(
            datas: itemBeans,
            duration: Duration(seconds: 2),
            scrollDirection: Axis.vertical,
            height: 30.0,
            itemBuilder: (context, index) {
              return new InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: itemBeans[index].name);
                },
                child: new GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      /// 拦截垂直方向的手势
                    },
                    child: new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          "${itemBeans[index].name}",
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
