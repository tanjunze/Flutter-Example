import 'package:flutter/material.dart';
import 'package:meiju_app/component/cache_image.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.70;

  Poster(
    this.posterUrl, {
    this.height = 60.0,
  });

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;

    return new Material(
      borderRadius: new BorderRadius.circular(4.0),
      elevation: 2.0,
      color: Colors.white,
      child: new Padding(
        padding: const EdgeInsets.all(5.0),
        child: new CacheLoadingImage(
          url: posterUrl,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
