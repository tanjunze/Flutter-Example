import 'package:flutter/material.dart';
import 'dart:async';

enum ExpandState {
  open,
  close,
  closeOpen,
}
typedef void ExpandCallback(ExpandState expandState);
typedef void ExpandStateLisenter(bool isOpen);

class ExpandController {
  ExpandCallback expandCallback;
  ExpandStateLisenter expandStateLisenter;
  void setExpandCallback(ExpandCallback expandCallback) {
    this.expandCallback = expandCallback;
  }

  void expand(ExpandState expandState) {
    if (expandCallback != null) {
      expandCallback(expandState);
    }
  }

  void setExpandStateLisenter(ExpandStateLisenter expandStateLisenter) {
    this.expandStateLisenter = expandStateLisenter;
  }

  void expandState(bool isOpen) {
    if (expandStateLisenter != null) {
      expandStateLisenter(isOpen);
    }
  }
}

class ExpandViewWidget extends StatefulWidget {
  ExpandViewWidget(
      {this.expandController, this.child, this.expandChild, this.expandHeight})
      : assert(expandController != null);
  final Widget child;
  final Widget expandChild;
  final double expandHeight;
  final ExpandController expandController;
  @override
  State<StatefulWidget> createState() {
    return new _ExpandViewWidget();
  }
}

class _ExpandViewWidget extends State<ExpandViewWidget> {
  bool closeWindow = true;
  @override
  void initState() {
    super.initState();
    widget.expandController.setExpandCallback((expandState) {
      if (expandState == ExpandState.close) {
      setWidgetState(true);
      } else {
         setWidgetState(false);
      }
    });
  }

  setWidgetState(close) {
    setState(() {
      closeWindow = close;
    });
  }

  delayedOpenWindow() {
    new Future.delayed(const Duration(milliseconds: 100), () {
      setWidgetState(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (closeWindow) {
      return new Expanded(
        child: widget.child,
      );
    }
    return new Expanded(
      child: _buildShadowWindow(),
    );
  }

  double expandHeight;
  Widget _buildShadowWindow() {
    List<Widget> widgets = <Widget>[];
    if (widget.child != null) {
      widgets.add(widget.child);
    }
    widgets.add(_buildForeground());
    return new Stack(
      children: widgets,
    );
  }

  Widget _buildForeground() {
    expandHeight = expandHeight == null ? 300.0 : expandHeight;
    return new Column(
      children: <Widget>[
        new Container(
          color: Colors.red,
          padding: const EdgeInsets.all(10.0),
          height: expandHeight,
          child: widget.expandChild,
        ),
        new Expanded(
            child: new GestureDetector(
                onTap: () {
                  widget.expandController.expand(ExpandState.close);
                  widget.expandController.expandState(!closeWindow);
                },
                child: new Container(
                  color: Colors.black54,
                )))
      ],
    );
  }
}
