import 'package:flutter/material.dart';
import 'package:meiju_app/page/MoiveDetailPage.dart';
import 'package:meiju_app/page/MoiveClassifyPage.dart';
import 'package:meiju_app/page/TakePhotoPage.dart';

/// 电影详情页面路由
const  moiveDetailRoute = "/moive_detail";

/// 电影分类页面路由
const moiveClassifyRoute = "/moive_classify";

///
const takePhotoRoute = "/take_photo";


Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  moiveDetailRoute: (BuildContext context) => new MoiveDetial(),
  moiveClassifyRoute: (BuildContext context) => new MoiveClassifyPage(),
  takePhotoRoute:(BuildContext context) => new TakePhotoPage(),
};

openPage(BuildContext context,String routeName){
  Navigator.pushNamed(context, routeName);
}
