import 'package:flutter/material.dart';
import 'package:meiju_app/view/component/expand_view.dart';
import 'package:flutter/gestures.dart';

typedef void OnTabTap(int index, bool isActive);
typedef void OnTabTaps(int index, ExpandState state);
typedef void CurrentIndexLisenter(bool isActive);

class MultSelectTabController {
  CurrentIndexLisenter _currentIndexLisenter;
  void setCurrentIndex(bool isActive) {
    if (_currentIndexLisenter != null) {
      _currentIndexLisenter(isActive);
    }
  }

  void setCurrentIndexLisenter(CurrentIndexLisenter currentIndexLisenter) {
    _currentIndexLisenter = currentIndexLisenter;
  }
}

class MultSelectItem {
  MultSelectItem({this.name});
  String name;
}

class MultSelectTabs extends StatefulWidget {
  MultSelectTabs({
    this.controller,
    this.height: 50.0,
    this.color: Colors.white,
    this.activeColor: Colors.red,
    this.normalColor: Colors.grey,
    this.tabItems,
    this.onTabTaps,
    this.moreName,
    this.onMoreTap
  });
  final MultSelectTabController controller;
  final Color color;
  final Color normalColor;
  final Color activeColor;
  final double height;
  final List<MultSelectItem> tabItems;
  final OnTabTaps onTabTaps;
  final String moreName;
  final GestureTapCallback onMoreTap;
  @override
  State<StatefulWidget> createState() {
    return new _MultSelectTabs();
  }
}

class _MultSelectTabs extends State<MultSelectTabs> {
  int currentIndex;
  bool active = false;
  int activeIndex;
  @override
  void initState() {
    super.initState();
    widget.controller?.setCurrentIndexLisenter((isActive) {
      setState(() {
        active=isActive;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int length=widget.moreName!=null?widget.tabItems.length+1:widget.tabItems.length;
    return new SizedBox.fromSize(
      size: new Size.fromHeight(50.0),
      child: new Material(
        color: widget.color,
        child: new Row(
          children: new List<Widget>.generate(length, (index) {
            if(widget.tabItems.length==index&&widget.moreName!=null){
              return new Expanded(
                child:  new MultOtherTab(name:widget.moreName,onTap: widget.onMoreTap,),
              );
            }
            MultSelectItem selectItem = widget.tabItems[index];
            return new Expanded(
              child: new MultSelectTab(
                activeColor: widget.activeColor,
                normalColor: widget.normalColor,
                name: selectItem.name,
                isActive: currentIndex == index && active,
                index: index,
                onTabTap: (tabindex, isActive) {
                  if (tabindex == currentIndex && isActive) {
                    widget.onTabTaps(tabindex, ExpandState.open);
                  } else if (tabindex == currentIndex && !isActive) {
                    widget.onTabTaps(tabindex, ExpandState.close);
                  } else {
                    if (currentIndex == null || !isActive) {
                      widget.onTabTaps(tabindex, ExpandState.open);
                    } else {
                      widget.onTabTaps(tabindex, ExpandState.closeOpen);
                    }
                  }
                  setState(() {
                    active = isActive;
                    currentIndex = tabindex;
                  });
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

class MultSelectTab extends StatefulWidget {
  MultSelectTab(
      {this.index,
      this.normalColor,
      this.activeColor,
      this.name,
      this.onTabTap,
      this.isActive});
  Color normalColor;
  Color activeColor;
  String name;
  OnTabTap onTabTap;
  bool isActive;
  int index;
  @override
  State<StatefulWidget> createState() {
    return new _MultSelectTab();
  }
}

class _MultSelectTab extends State<MultSelectTab> {
  @override
  Widget build(BuildContext context) {
    Color showColor = widget.isActive ? widget.activeColor : widget.normalColor;
    return new InkWell(
      onTap: () {
        widget.onTabTap(widget.index, !widget.isActive);
      },
      child: new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              widget.name,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: showColor,
              ),
            ),
            new Image.asset(
              'assets/images/arrow-down.png',
              color: showColor,
            )
          ],
        ),
      ),
    );
  }
}

class MultOtherTab extends StatelessWidget {

  MultOtherTab({
    this.name,
    this.onTap
  });
  String name;
  GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap:onTap,
      child: new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              name,
              textAlign: TextAlign.center,
              style: new TextStyle(
                color:  Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

