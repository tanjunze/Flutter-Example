import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

/// 缓存image
class CacheLoadingImage extends StatelessWidget {
  CacheLoadingImage({
    @required this.url,
    this.width,
    this.height
  });
  final String url;
  final double width;
  final double height;
  
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:BoxConstraints.expand(width: width,height: height),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: Center(child: new CircularProgressIndicator()),
        errorWidget: Center(child: new Icon(Icons.error),),
      ),
    );
  }
}
