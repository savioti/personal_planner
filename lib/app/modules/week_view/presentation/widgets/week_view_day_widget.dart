import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_day_section_divider_widget.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_day_title_divider_widget.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/event_widget.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/task_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/areas/disabled_area.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class WeekViewDayWidget extends StatelessWidget {
  final String title;
  final Weekday weekday;
  final DateTime date;
  final List<EventEntity> events;
  final List<TaskEntity> tasks;
  final Function(String eventId) onEventDelete;
  final Function(String taskId) onTaskComplete;
  final VoidCallback onTapAddEvent;

  const WeekViewDayWidget({
    super.key,
    required this.title,
    required this.weekday,
    required this.date,
    required this.events,
    required this.tasks,
    required this.onEventDelete,
    required this.onTaskComplete,
    required this.onTapAddEvent,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toDateOnly;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final weekViewWidth = AppDimensions.weekViewWidthRatio * screenWidth;
    final daysInAWeek = 7;
    final weekdayCardWidth =
        (weekViewWidth - (AppDimensions.paddingXLarge * 2)) / daysInAWeek;

    return DisabledArea(
      disabled: date.toDateOnly.isBefore(now),
      child: Container(
        width: weekdayCardWidth,
        decoration: BoxDecoration(
          color: _dayColor(context: context),
          borderRadius: BorderRadius.circular(
            AppDimensions.containerBorderRadius,
          ),
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: '$title (${date.toMonthDay})',
              style: theme.textTheme.titleMedium,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            WeekViewDayTitleDividerWidget(),
            const VerticalGap.medium(),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tasks.length,
              separatorBuilder: (_, index) => VerticalGap.small(),
              itemBuilder: (_, index) {
                final task = tasks[index];
                return TaskWidget(
                  task: task,
                  onComplete: () {
                    onTaskComplete(task.id);
                  },
                );
              },
            ),
            if (tasks.isNotEmpty) WeekViewDaySectionDividerWidget(),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: events.length,
              separatorBuilder: (_, index) => VerticalGap.small(),
              itemBuilder: (_, index) {
                // if (index == events.length) {
                //   if (date.isBefore(DateTime.now().toDateOnly)) {
                //     return SizedBox.shrink();
                //   }

                //   return AddEventWidget(onTap: onTapAddEvent);
                // }

                final event = events[index];
                return EventWidget(event: event);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color? _dayColor({required BuildContext context}) {
    final theme = Theme.of(context);
    final now = DateTime.now().toDateOnly;

    if (date.toDateOnly == now) {
      return theme.colorScheme.primaryContainer;
    }

    return null;
  }
}
