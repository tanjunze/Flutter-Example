import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum LoadState { Success, Fail, Loading }

class LoadStateController {
  Object errorMsg;
  LoadState state = LoadState.Loading;
}

class LoadStateView<T> extends StatelessWidget {
  LoadStateView({
    @required this.child,
    @required this.controller,
    this.loadView,
    this.errorView,
    this.onRetry,
  })  : assert(child != null),
        assert(controller != null);
  final LoadStateController controller;
  final Widget child;
  final Widget loadView;
  final Widget errorView;
  final GestureTapCallback onRetry;
  @override
  Widget build(BuildContext context) {
    Widget contentWidget;
    switch (controller.state) {
      case LoadState.Loading:
        contentWidget = _buildLoadView();
        break;
      case LoadState.Success:
        contentWidget = child;
        break;
      case LoadState.Fail:
        contentWidget = _buildErrorView(controller.errorMsg);
        break;
    }
    return contentWidget;
  }

  Widget _buildErrorView(Object errorMsg) {
    return new GestureDetector(
      onTap: () {
              controller.state=LoadState.Loading;
        onRetry();
      },
      child: errorView != null ? errorView : _buildDefaultErrorView(errorMsg),
    );
  }

  Widget _buildLoadView() {
    return loadView != null
        ? loadView
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildDefaultErrorView(Object errorMsg) {
    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/images/error.png",
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          errorMsg ??
              new Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Text(
                  "${errorMsg.toString()}",
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade800),
                ),
              ),
          new Text("点击重试！")
        ],
      ),
    );
  }
}
