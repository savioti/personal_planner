import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  final Color? color;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: AppDimensions.checkboxSize,
      height: AppDimensions.checkboxSize,
      child: Checkbox(
        value: value,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.checkboxBorderRadius,
          ),
        ),
        side: BorderSide(
          color: color ?? theme.colorScheme.onPrimary,
          width: 1.5,
        ),
        checkColor: theme.colorScheme.onPrimary,
        onChanged: onChanged,
      ),
    );
  }
}
