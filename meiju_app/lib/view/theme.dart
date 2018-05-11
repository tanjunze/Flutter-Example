import 'package:flutter/material.dart';

typedef void ThemeChange(ThemeData theme);

class AppTheme {
  static ThemeChange themeChange;
  static ThemeData currentTheme = redTheme;
  static void setTheme(ThemeData theme) {
    if (themeChange != null) {
      themeChange(theme);
    }
  }

  /// 监听主题改变
  static void changeLisenter(ThemeChange change) {
    themeChange = change;
  }
}

final ThemeData redTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
);

final ThemeData blueTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

// final ThemeData darkTheme = new ThemeData(
//   brightness: Brightness.dark,
//   primarySwatch: Colors.blue,
//   accentColor: Colors.orange
// );

// DialogManager.showColorPickerDialog(context, (color) {
//   AppTheme.setTheme(ThemeData(
//       brightness: Brightness.light,
//       primarySwatch: Colors.blue,
//       accentColor: Colors.green));
// });
