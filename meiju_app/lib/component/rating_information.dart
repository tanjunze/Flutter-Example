import 'package:flutter/material.dart';

class RatingInformation extends StatelessWidget {
  _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      var color =
          i <= 4 ? Colors.orangeAccent[700] : Colors.white.withOpacity(0.8);
      var star = new Icon(
        Icons.star,
        size: 15.0,
        color: color,
      );

      stars.add(star);
    }

    return new Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return _buildRatingBar(theme);
  }
}
