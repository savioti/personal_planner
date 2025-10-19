import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/theme/color_tokens.dart';

class WeekViewDaySectionDividerWidget extends StatelessWidget {
  const WeekViewDaySectionDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacingSmall,
        ),
        child: SizedBox(
          width: AppDimensions.weekViewHorizontalDividerLength,
          child: Divider(
            color: ColorTokens.unselected,
            thickness: 1.0,
            height: AppDimensions.weekViewTaskItemHeight,
          ),
        ),
      ),
    );
  }
}
