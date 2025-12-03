import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/core/utils/app_ext.dart';

class OTPWidget extends StatefulWidget {
  final ValueChanged<String>? onCompleted;
  const OTPWidget({super.key, this.onCompleted});

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  final int otpLength = 6;

  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    controllers = List.generate(otpLength, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final node in focusNodes) {
      node.dispose();
    }
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(otpLength, (index) {
          return SizedBox(
            height: 60.h,
            width: 50.w,
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: textTheme.titleLarge?.copyWith(
                color: colors.onSurface,
              ),
              cursorColor: colors.primary,
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                fillColor: colors.surfaceContainerHighest,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < otpLength - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                }
                if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
                final otpCode = controllers.map((c) => c.text).join();
                if (otpCode.length == otpLength) {
                  widget.onCompleted?.call(otpCode);
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
