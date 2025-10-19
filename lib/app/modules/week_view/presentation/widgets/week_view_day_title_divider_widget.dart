import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class WeekViewDayTitleDividerWidget extends StatelessWidget {
  const WeekViewDayTitleDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSmall),
      child: Divider(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        thickness: 2.0,
        height: 2.0,
      ),
    );
  }
}
