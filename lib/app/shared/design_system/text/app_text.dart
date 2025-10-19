import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/font_families.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final String? fontFamily;
  final Color? color;
  final TextDecoration? decoration;

  const AppText({
    super.key,
    required this.text,
    this.style,
    this.fontFamily,
    this.color,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style:
          style?.copyWith(
            fontFamily: fontFamily ?? FontFamilies.defaultFontFamily,
            color: color ?? theme.colorScheme.onSurface,
            decoration: decoration,
          ) ??
          AppTextStyles.bodyMedium().copyWith(
            fontFamily: fontFamily ?? FontFamilies.defaultFontFamily,
            color: color ?? theme.colorScheme.onSurface,
            decoration: decoration,
          ),
    );
  }
}
