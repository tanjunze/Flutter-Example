import 'package:flutter/material.dart';
import 'package:flutter_compt/page/routes.dart';
import 'package:flutter_compt/page/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home: HomePage(),
    );
  }
}
