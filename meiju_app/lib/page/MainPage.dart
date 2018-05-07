import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meiju_app/page/HomePage.dart';
import 'package:meiju_app/page/MePage.dart';
import 'package:meiju_app/component/BottomNavWidget.dart';
import 'package:meiju_app/util/global.dart';
import 'package:meiju_app/component/tab_content_view.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: pageColor,
      body: TabContentView(
        currentIndex: index,
        contents: <Widget>[
          HomePage(),
          MePage()
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return new CupertinoTabBar(
      activeColor: Colors.red,
      currentIndex: BottomNavWidget.currentIndex,
      onTap: (int index) {
        setState(() {
          this.index = index;
          BottomNavWidget.currentIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          title: const Text('首页'),
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          title: const Text('我的'),
        ),
      ],
    );
  }
}
