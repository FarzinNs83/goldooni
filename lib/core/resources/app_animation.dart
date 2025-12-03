import 'package:flutter/widgets.dart';
class FadeSlideAnimation extends StatefulWidget {
  final Widget child;

  const FadeSlideAnimation({super.key, required this.child});

  @override
  State<FadeSlideAnimation> createState() => _FadeSlideAnimationState();
}

class _FadeSlideAnimationState extends State<FadeSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController.drive(Tween(begin: 0, end: 1)),
      child: SlideTransition(
        position: animationController.drive(
          Tween(
            begin: Offset(-0.7, -0.3),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: widget.child,
      ),
    );
  }
}
