import 'package:flutter/material.dart';
import 'package:meiju_app/ui/page/Moive_Detail_Page.dart';
import 'package:meiju_app/ui/page/Moive_Classify_Page.dart';
import 'package:meiju_app/ui/page/Take_Photo_Page.dart';
import 'package:meiju_app/ui/page/WebView_Page.dart';

/// 电影详情页面路由
const moiveDetailRoute = "/moive_detail";

/// 电影分类页面路由
const moiveClassifyRoute = "/moive_classify";

/// 自定义相机
const takePhotoRoute = "/take_photo";

Map<String, Widget> pages = <String, Widget>{
  moiveDetailRoute: MoiveDetial(),
  moiveClassifyRoute: MoiveClassifyPage(),
  takePhotoRoute: TakePhotoPage()
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

openWebView(BuildContext context, String url) {
  Navigator.push(context, buildAnimRoute(new WebViewPage(url)));
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
