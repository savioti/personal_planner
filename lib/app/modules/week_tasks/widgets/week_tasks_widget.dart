import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class WeekTasksWidget extends StatelessWidget {
  const WeekTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = serviceLocator.get<TranslationsController>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: AppDimensions.weekTasksWidthRatio * screenWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr('week_tasks.title'),
            style: AppTextStyles.titleMedium(),
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          // Add your week tasks content here
          Text('Task 1'),
          Text('Task 2'),
          Text('Task 3'),
        ],
      ),
    );
  }
}
