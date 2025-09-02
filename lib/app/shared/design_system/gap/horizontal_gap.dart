import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class HorizontalGap extends StatelessWidget {
  final double width;

  const HorizontalGap({super.key, this.width = AppDimensions.spacingMedium});

  const HorizontalGap.tiny({super.key}) : width = AppDimensions.spacingTiny;
  const HorizontalGap.small({super.key}) : width = AppDimensions.spacingSmall;
  const HorizontalGap.medium({super.key}) : width = AppDimensions.spacingMedium;
  const HorizontalGap.large({super.key}) : width = AppDimensions.spacingLarge;
  const HorizontalGap.extraLarge({super.key})
    : width = AppDimensions.spacingXLarge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
