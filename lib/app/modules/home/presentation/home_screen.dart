import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/pending_tasks_widget.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/tile_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildExtraFeatures(context: context),
            HorizontalGap.large(),
            WeekViewWidget(),
            HorizontalGap.large(),
            PendingTasksWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildExtraFeatures({required BuildContext context}) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(
            AppDimensions.containerBorderRadius,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: ExtraFeaturesTranslations.title,
              color: theme.colorScheme.onPrimaryContainer,
              style: theme.textTheme.titleMedium,
            ),
            VerticalGap.large(),
            TileButton(
              label: ExtraFeaturesTranslations.shoppingList,
              onPressed: () {},
            ),
            VerticalGap.large(),
            TileButton(
              label: ExtraFeaturesTranslations.finances,
              onPressed: () {},
            ),
            VerticalGap.large(),
            TileButton(
              label: ExtraFeaturesTranslations.dayDiary,
              onPressed: () {},
            ),
            VerticalGap.medium(),
            TileButton(
              label: ExtraFeaturesTranslations.mealPlan,
              onPressed: () {},
            ),
            VerticalGap.medium(),
            TileButton(
              label: ExtraFeaturesTranslations.travelChecklist,
              onPressed: () {},
            ),
            VerticalGap.medium(),
            TileButton(
              label: ExtraFeaturesTranslations.settings,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
