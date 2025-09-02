import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color? color;

  const AppIcon({super.key, required this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Icon(
      iconData,
      color: color ?? theme.colorScheme.onSurface,
      size: AppDimensions.iconSizeMedium,
    );
  }
}
