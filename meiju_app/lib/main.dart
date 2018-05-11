import 'package:flutter/material.dart';
import 'package:meiju_app/view/page/main_page.dart';
import 'package:meiju_app/data/httpserver/simple_server.dart';
import 'package:meiju_app/view/page/routes.dart';
import 'package:meiju_app/view/theme.dart';

void main() {
  runHttpServer();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppTheme.changeLisenter((theme) {
      setState(() => AppTheme.currentTheme = theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '美剧APP',
      theme: AppTheme.currentTheme,
      routes: routes,
      home: new MainPage(),
    );
  }
}

/// 开启 Http 服务
runHttpServer() {
  SimpleServer server = new SimpleServer();
  server.closeServer();
  server.startServer();
}
