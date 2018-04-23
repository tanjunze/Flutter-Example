// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomTabLayout extends StatefulWidget {
  BottomTabLayout({
    Key key,
    this.items,
    this.onTap,
    this.currentIndex: 0,
    this.fixedColor,
    this.iconSize: 24.0,
  })
      : assert(items != null),
        assert(items.length >= 2),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        super(key: key);

  final List<BottomNavigationBarItem> items;

  final ValueChanged<int> onTap;

  final int currentIndex;

  final Color fixedColor;

  final double iconSize;

  @override
  _BottomNavigationBarState createState() => new _BottomNavigationBarState();
}

class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(this.item, this.animation, this.iconSize,
      {this.onTap, this.colorTween, this.flex});
  final BottomNavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback onTap;
  final ColorTween colorTween;
  final double flex;

  Widget _buildIcon() {
    Color iconColor;
    iconColor = colorTween.evaluate(animation);
    return new Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: new Container(
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: iconSize,
          ),
          child: item.icon,
        ),
      ),
    );
  }

  Widget _buildFixedLabel() {
    return new Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: new Container(
        child: DefaultTextStyle.merge(
          style: new TextStyle(
            color: colorTween.evaluate(animation),
          ),
          child: item.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int size;
    Widget label;
    size = 1;
    label = _buildFixedLabel();
    return new Expanded(
      flex: size,
      child: new InkResponse(
        onTap: onTap,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildIcon(),
            label,
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBarState extends State<BottomTabLayout>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers;
  List<CurvedAnimation> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = new List<AnimationController>.generate(widget.items.length,
        (int index) {
      return new AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        new List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return new CurvedAnimation(
          parent: _controllers[index],
          curve: Curves.fastOutSlowIn,
          reverseCurve: Curves.fastOutSlowIn.flipped);
    });
    _controllers[widget.currentIndex].value = 1.0;
  }

  void _rebuild() {
    setState(() {
      // Rebuilding when any of the controllers tick, i.e. when the items are
      // animated.
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BottomTabLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  List<Widget> _createTiles() {
    final List<Widget> children = <Widget>[];
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    Color themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.primaryColor;
        break;
      case Brightness.dark:
        themeColor = themeData.accentColor;
        break;
    }
    final ColorTween colorTween = new ColorTween(
      begin: textTheme.caption.color,
      end: widget.fixedColor ?? themeColor,
    );
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(
        new _BottomNavigationTile(
          widget.items[i],
          _animations[i],
          widget.iconSize,
          onTap: () {
            if (widget.onTap != null) widget.onTap(i);
          },
          colorTween: colorTween,
        ),
      );
    }
    return children;
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    Color backgroundColor;
    return new Stack(
      children: <Widget>[
        new Positioned.fill(
          child: new Material(
            // Casts shadow.
            elevation: 8.0,
            color: backgroundColor,
          ),
        ),
        new ConstrainedBox(
          constraints:
              new BoxConstraints(minHeight: kBottomNavigationBarHeight-6),
          child: new Material(
            // Splashes.
            type: MaterialType.transparency,
            child: _createContainer(_createTiles()),
          ),
        ),
      ],
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