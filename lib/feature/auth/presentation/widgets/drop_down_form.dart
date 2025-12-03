
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:goldooni/core/utils/app_ext.dart';

// ignore: must_be_immutable
class DropDownForm extends StatefulWidget {
  DropDownForm({
    super.key,
    required this.value,
    required this.items,
    required this.hint, required this.onChanged,
  });
  String? value;
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;

  @override
  State<DropDownForm> createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    final textTheme = context.textTheme;
    return Form(
      child: DropdownButtonFormField<String>(
        menuMaxHeight: 0.4.sh,
        dropdownColor: colors.surfaceContainerHighest,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: colors.onSurface,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: colors.surfaceContainerHighest,
          hintText: widget.hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: colors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) =>
            value == null ? 'لطفاً تاریخ تولد را انتخاب کنید' : null,
        style: textTheme.bodyMedium?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.w600,
        ),
        borderRadius: BorderRadius.circular(16.r),
        items: widget.items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: widget.onChanged
        // (values) {
        //   setState(() {
        //     widget.value = values;
        //     log(values.toString());
        //   });
        // },
      ),
    );
  }
}
