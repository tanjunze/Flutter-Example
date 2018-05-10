import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meiju_app/view/page/home_page.dart';
import 'package:meiju_app/view/page/me_page.dart';
import 'package:meiju_app/view/component/bottom_bavigation_bar.dart';
import 'package:meiju_app/util/global.dart';
import 'package:meiju_app/view/component/tab_content_view.dart';

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
