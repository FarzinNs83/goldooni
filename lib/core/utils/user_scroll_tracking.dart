import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserScrollTracking extends StatelessWidget {
  final Widget child;
  final VoidCallback funcR;
  final VoidCallback funcF;
  const UserScrollTracking({
    super.key,
    required this.child,
    required this.funcR,
    required this.funcF,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.axis == Axis.vertical) {
          if (notification.direction == ScrollDirection.reverse) {
            funcR();
          } else if (notification.direction == ScrollDirection.forward) {
            funcF();
          }
        }
        return false;
      },
      child: child,
    );
  }
}
