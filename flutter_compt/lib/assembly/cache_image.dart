import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

/// 缓存image
class CacheLoadingImage extends StatelessWidget {
  CacheLoadingImage({
    @required this.url,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: Center(child: new CircularProgressIndicator()),
        errorWidget: Center(child: new Icon(Icons.error),),
      ),
    );
  }
}
