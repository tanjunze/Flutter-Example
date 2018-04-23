import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 缓存image
class CacheLoadingImage extends StatelessWidget {
  CacheLoadingImage({this.url, this.height, this.width});
  double height;
  double width;
  String url;

  @override
  Widget build(BuildContext context) {
    return new CachedNetworkImage(
      fit: BoxFit.cover,
      height: height,
      width: width,
      imageUrl: url,
      placeholder: _buildSizeChlid(new CircularProgressIndicator()),
      errorWidget:_buildSizeChlid(new Icon(Icons.error)),
    );
  }

  Widget _buildSizeChlid(Widget childView){
    return new Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: childView ,
      );
  }
}
