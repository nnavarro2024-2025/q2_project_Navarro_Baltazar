import 'package:edc_v2/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DefaultCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const DefaultCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.onSurface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          onChanged.call(!value);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 32,
          width: 32,
          child: AnimatedSwitcher(
            duration: Duration(seconds: 1),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              ); // ScaleTransition
            },
            child: value
                ? Icon(
                  Icons.check, 
                  color: AppColors.text, 
                  size: 24
                  ) // Icon
                : null,
          ), // AnimatedSwitcher
        ),
      ),
    ); // Container
  }
}
