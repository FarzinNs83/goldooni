import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goldooni/core/widgets/show_toast.dart';

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
          ShowToast().show('برای خروج دوبار کلیک کنید', context);
          return;
        }
        await SystemNavigator.pop();
      },
      child: widget.child,
    );
  }
}
