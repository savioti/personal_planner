import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/task_form_dialog.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/event_form_dialog.dart';
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
  final Function(String taskId) onTaskDelete;
  final VoidCallback onSave;
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
    required this.onTaskDelete,
    required this.onSave,
    required this.onTaskComplete,
    required this.onTapAddEvent,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toDateOnly;
    final theme = Theme.of(context);

    return DisabledArea(
      disabled: date.toDateOnly.isBefore(now),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingTiny,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: '$title (${date.toMonthDay})',
                style: theme.textTheme.titleMedium,
                color: theme.colorScheme.onPrimaryContainer,
              ),
              WeekViewDayTitleDividerWidget(),
              Container(
                decoration: date.isToday
                    ? BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.containerBorderRadius,
                        ),
                      )
                    : null,
                child: Column(
                  children: [
                    _buildTasksSection(context: context),
                    VerticalGap.medium(),
                    _buildEventsSection(context: context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTasksSection({required BuildContext context}) {
    if (tasks.isEmpty) {
      return SizedBox.shrink();
    }

    return ListView.separated(
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
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: TaskFormDialog(
                    task: task,
                    onSave: onSave,
                    onDelete: () => onTaskDelete(task.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEventsSection({required BuildContext context}) {
    if (events.isEmpty) {
      return SizedBox.shrink();
    }

    final sortedEvents = List<EventEntity>.from(events)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sortedEvents.length,
      separatorBuilder: (_, index) => VerticalGap.small(),
      itemBuilder: (_, index) {
        final event = sortedEvents[index];

        return EventWidget(
          event: event,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: EventFormDialog(
                    event: event,
                    onSave: () => onSave.call(),
                    onDelete: () => onEventDelete.call(event.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
