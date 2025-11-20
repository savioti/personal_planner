import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  final Color? borderColor;
  final Color? checkColor;
  final Color? fillColor;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.borderColor,
    this.checkColor,
    this.fillColor,
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
          color: borderColor ?? theme.colorScheme.onPrimary,
          width: 1.5,
        ),
        checkColor: checkColor ?? theme.colorScheme.onPrimary,
        fillColor: WidgetStateProperty.all<Color>(
          fillColor ?? theme.colorScheme.primary,
        ),
        hoverColor: Colors.white.withValues(alpha: 0.1),
        onChanged: onChanged,
      ),
    );
  }
}
