import 'package:flutter/material.dart';
///
/// 首页导航tab
class BottomNavWidget {
  final ValueChanged<int> onBottomTap;

  BottomNavWidget(this.onBottomTap);

  static List<BottomNavigationBarItem> navigationViews =
      <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(
          '推荐',
          style: new TextStyle(fontSize: 10.0),
        ),
        backgroundColor: Colors.deepPurple),
    new BottomNavigationBarItem(
      icon: const Icon(Icons.account_box),
      title: new Text(
        '我的',
        style: new TextStyle(fontSize: 10.0),
      ),
      backgroundColor: Colors.teal,
    )
  ];
  static int currentIndex = 0;

  Widget getBottomNavigationBar() {
    return new BottomNavigationBar(
      items: BottomNavWidget.navigationViews,
      currentIndex: BottomNavWidget.currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onBottomTap,
    );
  }
}



// example
  // Widget _buildButtomNavBar() {
  //   // BottomNavigationBar
  //   return new BottomTabLayout(
  //     items: BottomNavWidget.navigationViews,
  //     currentIndex: BottomNavWidget.currentIndex,
  //     onTap: (int index) {
  //       setState(() {
  //         this.index = index;
  //         BottomNavWidget.currentIndex = index;
  //       });
  //     },
  //   );
  // }
