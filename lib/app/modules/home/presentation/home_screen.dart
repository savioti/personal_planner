import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/events/presentation/widgets/today_events.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/pending_tasks_widget.dart';
import 'package:personal_planner/app/modules/upcoming_events/presentation/widgets/upcoming_events_widget.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';

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
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Flexible(flex: 2, child: WeekViewWidget()),
                  VerticalGap.large(),
                  Flexible(child: UpcomingEventsWidget()),
                ],
              ),
            ),
            HorizontalGap.large(),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Flexible(child: TodayEventsWidget()),
                  VerticalGap.large(),
                  Flexible(child: PendingTasksWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
