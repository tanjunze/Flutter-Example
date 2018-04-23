import 'package:flutter/material.dart';
import 'package:meiju_app/page/MoiveDetailPage.dart';
import 'package:meiju_app/page/MoiveClassifyPage.dart';

/// 电影详情页面路由
const  moiveDetailRoute = "/moive_detail";

/// 电影分类页面路由
const moiveClassifyRoute = "/moive_classify";


Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  moiveDetailRoute: (BuildContext context) => new MoiveDetial(),
  moiveClassifyRoute: (BuildContext context) => new MoiveClassifyPage(),
};

openPage(BuildContext context,String routeName){
  Navigator.pushNamed(context, routeName);
}
