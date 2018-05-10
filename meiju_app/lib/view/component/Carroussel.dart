import 'package:flutter/material.dart';
import 'package:meiju_app/data/data.dart';
// import 'package:meiju_app/component/LoopImageItem.dart';

class Carroussel extends StatefulWidget {
  @override
  _CarrousselState createState() => new _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = new PageController(
      initialPage: itemBeans.length * 2,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 250.0,
        width: double.INFINITY,
        child: new PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentpage = value;
            });
          },
          controller: controller,
          itemBuilder: (context, index) {
            return _builder(index, index % itemBeans.length);
          },
        ));
  }

  Widget _builder(int index, int pos) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 0.8;
        try {
          value = controller.page - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        } on Exception catch (e) {
          print('Unknown exception: $e');
        }
        return new Center(
          child: new SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            width: Curves.easeOut.transform(value) * 250,
            child: child,
          ),
        );
      },
      child: new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Image.network(
          itemBeans[pos].url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
