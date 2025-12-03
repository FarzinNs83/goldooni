import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class DoubleTapToExit extends StatefulWidget {
  final Widget child;

  const DoubleTapToExit({super.key, required this.child});

  @override
  State<DoubleTapToExit> createState() => _DoubleTapToExitState();
}

class _DoubleTapToExitState extends State<DoubleTapToExit> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2)) {
          currentBackPressTime = now;
          showToast(
            'برای خروج دوباره کلیک کنید',
            context: context,
            animation: StyledToastAnimation.scale,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.bottom,
            animDuration: Duration(seconds: 1),
            duration: Duration(seconds: 4),
            curve: Curves.elasticOut,
            reverseCurve: Curves.linear,
          );
          return;
        }
        await SystemNavigator.pop();
      },
      child: widget.child,
    );
  }
}
