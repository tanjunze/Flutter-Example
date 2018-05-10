import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoomable_image/zoomable_image.dart';

class ImageCarousel extends StatefulWidget {
  final List<ImageProvider> imageProviders;
  final double height;
  final TargetPlatform platform;
  final Duration interval;
  final bool allowZoom;
  final TabController tabController;
  final BoxFit fit;

  // Images will shrink according to the value of [height]
  // If you prefer to use the Material or Cupertino style activity indicator set the [platform] parameter
  // Set [interval] to let the carousel loop through each photo automatically
  // Pinch to zoom will be turned on by default
  ImageCarousel(this.imageProviders,
      {this.height = 250.0, this.platform, this.interval, this.allowZoom = true, this.tabController, this.fit = BoxFit.cover});

  @override
  State createState() => new _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController ?? new TabController(vsync: this, length: widget.imageProviders.length);

    if (widget.interval != null) {
      new Timer.periodic(widget.interval, (_) {
        _tabController.animateTo(_tabController.index == _tabController.length - 1 ? 0 : ++_tabController.index);
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: widget.height,
      child: new TabBarView(
        controller: _tabController,
        children: widget.imageProviders.map((ImageProvider provider) {
          return new CarouselImageWidget(widget, provider, widget.fit, widget.height);
        }).toList(),
      ),
    );
  }
}

class CarouselImageWidget extends StatefulWidget {
  final ImageCarousel carousel;
  final ImageProvider imageProvider;
  final BoxFit fit;
  final double height;

  CarouselImageWidget(this.carousel, this.imageProvider, this.fit, this.height);

  @override
  State createState() => new _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImageWidget> {
  bool _loading = true;

  Widget _getIndicator(TargetPlatform platform) {
    if (platform == TargetPlatform.iOS) {
      return new CupertinoActivityIndicator();
    } else {
      return new Container(
        height: 40.0,
        width: 40.0,
        child: new CircularProgressIndicator(),
      );
    }
  }

  void _toZoomRoute() {
    Widget scaffold = new Scaffold(
      appBar: new AppBar(),
      body: new Center(
        child: new ZoomableImage(
          widget.imageProvider,
          scale: 16.0,
        ),
      ),
    );

    Navigator.of(context).push(
          defaultTargetPlatform == TargetPlatform.iOS
              ? new CupertinoPageRoute(builder: (BuildContext context) => scaffold, fullscreenDialog: true)
              : new MaterialPageRoute(builder: (BuildContext context) => scaffold, fullscreenDialog: true),
        );
  }

  @override
  void initState() {
    super.initState();

    widget.imageProvider.resolve(new ImageConfiguration()).addListener((i, b) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: widget.height,
      child: _loading
          ? _getIndicator(widget.carousel.platform == null ? defaultTargetPlatform : widget.carousel.platform)
          : new GestureDetector(
              child: new Image(
                image: widget.imageProvider,
                fit: widget.fit,
              ),
              onTap: () {
                if (widget.carousel.allowZoom) {
                  _toZoomRoute();
                }
              },
            ),
    );
  }
}
