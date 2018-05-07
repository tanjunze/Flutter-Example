import 'package:flutter/material.dart';
import 'package:flutter_compt/page/roll_page.dart';
import 'package:flutter_compt/page/wheel_page.dart';

/// 循环图片
const LoopViewRoute = "/loopView";
const WheelViewRoute = "/wheelView";

Map<String, Widget> pages = <String, Widget>{
  LoopViewRoute: RollImagePage(),
  WheelViewRoute:WheelPickerPage(),
};

Map<String, WidgetBuilder> routes = pages.map((name, page) {
  return MapEntry(name, (BuildContext context) => page);
});

openPage(BuildContext context, String routeName, {bool useDefault=false}) {
  if (useDefault) {
    Navigator.pushNamed(context, routeName);
  } else {
    Navigator.push(context, buildAnimRoute(pages[routeName]));
  }
}

buildAnimRoute(Widget page) {
  return PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return page;
      },
      transitionsBuilder:
          (___, Animation<double> animation, ____, Widget child) {
        return new FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}

buildMaterialRoute(Widget page) {
  return MaterialPageRoute(builder: (context) => page);
}
