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
        settings: RouteSettings(arguments: {'hideNavBar': true}),
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

  Future<dynamic> navigateWNavBar(Widget page) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        settings: RouteSettings(arguments: {'hideNavBar': false}),
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
        settings: RouteSettings(arguments: {'hideNavBar': true}),
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
  static const _persian = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
  static const _english = ['0','1','2','3','4','5','6','7','8','9'];

  String toEnglishNumber() {
    var result = this;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(_persian[i], _english[i]);
    }
    return result;
  }

  String toPersianNumber() {
    var result = this;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(_english[i], _persian[i]);
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
