import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class AppIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color? color;

  const AppIconButton({
    super.key,
    required this.iconData,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: IconButton(
        constraints: BoxConstraints(
          minWidth: AppDimensions.iconButtonSize,
          minHeight: AppDimensions.iconButtonSize,
        ),
        iconSize: AppDimensions.iconButtonIconSize,
        icon: Icon(iconData, color: color ?? theme.colorScheme.onPrimary),
        onPressed: onPressed,
      ),
    );
  }
}
