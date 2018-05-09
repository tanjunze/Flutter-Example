import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

typedef Widget WidgetBuilder<T>(T data);

class FutureBodyView<T> extends StatelessWidget {
  FutureBodyView({
    @required this.bodyBuilder,
    @required this.future,
    this.loadView,
    this.errorView,
    this.onRetry,
  })  : assert(bodyBuilder != null),
        assert(future != null);
  final WidgetBuilder<T> bodyBuilder;
  final Widget loadView;
  Widget errorView;
  final Future<T> future;
  final GestureTapCallback onRetry;
  Object error;


  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return bodyBuilder(snapshot.data);
        } else if (snapshot.hasError) {
          error = snapshot.error;
          return buildErrorView(error);
        }
        return loadView != null ? loadView : Center(child: CircularProgressIndicator(),);
      },
    );

  }

  Widget buildErrorView(Object msg) {
    if (errorView == null) {
      errorView = buildDefaultErrorView(msg);
    }
    return new GestureDetector(
      onTap: onRetry,
      child: errorView,
    );
  }

  Widget buildDefaultErrorView(Object msg) {
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
          new Padding(
            padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: new Text(
              "${msg.toString()}",
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade800
              ),
            ),
          ),
          new Text("点击重试！")
        ],
      ),
    );
  }
}
