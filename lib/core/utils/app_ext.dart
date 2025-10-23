import 'package:flutter/material.dart';

extension SizedBoxExt on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension MediaQueryExt on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension TextThemeExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension Navigate on BuildContext {
  navigate(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
  }

  navigateR(Widget page) {
    Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
}
