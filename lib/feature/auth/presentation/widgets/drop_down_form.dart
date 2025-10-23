import 'package:flutter/material.dart';

import 'package:goldooni/core/resources/app_colors.dart';
import 'package:goldooni/core/utils/app_ext.dart';

// ignore: must_be_immutable
class DropDownForm extends StatefulWidget {
  DropDownForm({super.key, required this.value, required this.items, required this.hint});
  String? value;
  final List<String> items;
  final String hint;

  @override
  State<DropDownForm> createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: DropdownButtonFormField<String>(
        menuMaxHeight: context.screenHeight * .4,
        dropdownColor: AppColors.fourthColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.neturalColor8,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.teriaryColor.withValues(alpha: .5),
          hintText: widget.hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) =>
            value == null ? 'لطفاً تاریخ تولد را انتخاب کنید' : null,
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.neturalColor8,
          fontWeight: FontWeight.w500,
        ),
        borderRadius: BorderRadius.circular(16),
        items: widget.items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: const TextStyle(
                    color: AppColors.neturalColor8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (values) {
          setState(() {
            widget.value = values;
          });
        },
      ),
    );
  }
}
