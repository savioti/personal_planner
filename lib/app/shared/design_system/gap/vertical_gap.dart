import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class VerticalGap extends StatelessWidget {
  final double height;

  const VerticalGap({super.key, this.height = AppDimensions.spacingMedium});

  const VerticalGap.tiny({super.key}) : height = AppDimensions.spacingTiny;
  const VerticalGap.small({super.key}) : height = AppDimensions.spacingSmall;
  const VerticalGap.medium({super.key}) : height = AppDimensions.spacingMedium;
  const VerticalGap.large({super.key}) : height = AppDimensions.spacingLarge;
  const VerticalGap.extraLarge({super.key})
    : height = AppDimensions.spacingXLarge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
