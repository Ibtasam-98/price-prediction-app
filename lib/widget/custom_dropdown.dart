

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';
import 'custom_text.dart';

class DropdownInput extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  DropdownInput({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: (newValue) {
        onChanged(newValue);
      },
      items: items.map<DropdownMenuItem<String>>((String itemValue) {
        return DropdownMenuItem<String>(
          value: itemValue,
          child: CustomText(
            title: itemValue,
            fontSize: 13.sp,
            capitalize: true,
          ),
        );
      }).toList(),
      dropdownColor: AppColors.white,
      isExpanded: true,
      underline: Container(),
    );
  }
}