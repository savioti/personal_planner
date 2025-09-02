import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class AppIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const AppIconButton({super.key, required this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: BoxConstraints(
        minWidth: AppDimensions.iconButtonSize,
        minHeight: AppDimensions.iconButtonSize,
      ),
      iconSize: AppDimensions.iconButtonIconSize,
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }
}
