import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/presentation/widgets/week_view_event_widget.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/presentation/widgets/task_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/e_weekday.dart';

class WeekviewDayWidget extends StatelessWidget {
  final String title;
  final EWeekday weekday;
  final List<EventEntity> events;
  final List<TaskEntity> tasks;
  final Function(String eventId) onEventDelete;
  final Function(String taskId) onTaskComplete;
  final Function(String taskId) onTaskDelete;
  final bool useVariantColor;

  const WeekviewDayWidget({
    super.key,
    required this.weekday,
    required this.title,
    required this.events,
    required this.tasks,
    required this.onEventDelete,
    required this.onTaskComplete,
    required this.onTaskDelete,
    this.useVariantColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final weekViewWidth = AppDimensions.weekViewWidthRatio * screenWidth;
    final weekdayCardWidth =
        (weekViewWidth - AppDimensions.cardPadding * 2) / 7;

    return Container(
      width: weekdayCardWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: useVariantColor
            ? theme.colorScheme.surfaceContainerLow
            : theme.colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          AppText(text: title, color: theme.colorScheme.onPrimary),
          const VerticalGap.medium(),
          ListView.separated(
            shrinkWrap: true,
            itemCount: tasks.length,
            separatorBuilder: (_, index) => const VerticalGap.small(),
            itemBuilder: (_, index) {
              final task = tasks[index];
              return TaskWidget(
                displayVertically: true,
                task: task,
                onDelete: onTaskDelete,
                onComplete: onTaskComplete,
              );
            },
          ),
          if (tasks.isNotEmpty) const VerticalGap.medium(),
          ListView.separated(
            shrinkWrap: true,
            itemCount: events.length,
            separatorBuilder: (_, index) => const VerticalGap.small(),
            itemBuilder: (_, index) {
              final event = events[index];
              return WeekViewEventWidget(event: event, onDelete: onEventDelete);
            },
          ),
        ],
      ),
    );
  }
}
