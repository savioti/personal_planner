import 'package:flutter/material.dart';
import 'package:personal_planner/shared/constants/font_families.dart';
import 'package:personal_planner/shared/theme/text_styles.dart';

class DSText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final String? fontFamily;
  final Color? color;

  const DSText({
    super.key,
    required this.text,
    this.style,
    this.fontFamily,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      style:
          style?.copyWith(
            fontFamily: fontFamily ?? FontFamilies.defaultFontFamily,
            color: color ?? theme.colorScheme.onSurface,
          ) ??
          TextStyles.regular().copyWith(
            fontFamily: fontFamily ?? FontFamilies.defaultFontFamily,
            color: color ?? theme.colorScheme.onSurface,
          ),
    );
  }
}
