
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';



class SliderInput extends StatelessWidget {
  final double value;
  final Function(double) onChanged;
  final double min;
  final double max;

  SliderInput({
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: AppColors.primary,
      inactiveColor: AppColors.grey.withOpacity(0.5),
      value: value,
      onChanged: (newValue) {
        onChanged(newValue);
      },
      min: min,
      max: max,
      divisions: (max - min).toInt(),
      label: value.toInt().toString(),
    );


  }
}