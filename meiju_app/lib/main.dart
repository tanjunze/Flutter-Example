import 'package:flutter/material.dart';
import 'package:meiju_app/ui/page/main_page.dart';
import 'package:meiju_app/data/httpserver/simple_server.dart';
import 'package:meiju_app/ui/page/routes.dart';
void main()  {
  runHttpServer();
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '美剧APP',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
      home: new MainPage(),
    );
  }
}

/// 开启 Http 服务
runHttpServer(){
  SimpleServer server=new SimpleServer();
  server.closeServer();
  server.startServer();
}




