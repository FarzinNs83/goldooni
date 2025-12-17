import 'package:flutter/material.dart';

extension SizedBoxExt on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension TextThemeExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension Navigate on BuildContext {
  Future<dynamic> navigate(Widget page) {
    return Navigator.push(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(1, 0),
                end: Offset(0, 0),
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: page,
          );
        },
      ),
    );
  }

  Future<dynamic> navigateRoot(Widget page) {
    return Navigator.of(this, rootNavigator: false).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(1, 0),
                end: Offset(0, 0),
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: page,
          );
        },
      ),
    );
  }

  Future<dynamic> navigateR(Widget page) {
    return Navigator.pushReplacement(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return SlideTransition(
            position: animation.drive(
              Tween(
                begin: Offset(1, 0),
                end: Offset(0, 0),
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: page,
          );
        },
      ),
    );
  }
}

extension PersianNumbers on String {
  String toPersianNumber() {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    var result = this;
    for (var i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], persian[i]);
    }
    return result;
  }
}

extension Comma on num {
  String get comma =>
      toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
}

extension MonthsToNum on String {
  String toNum() {
    const months = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];
    final index = months.indexOf(this);
    return (index + 1).toString();
  }
}
