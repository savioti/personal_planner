import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/task_form_dialog.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/event_form_dialog.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_day_title_divider_widget.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/event_widget.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/task_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/areas/disabled_area.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
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
  final List<EventEntity> recurringEvents;
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
    required this.recurringEvents,
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
              _buildTasksSection(context: context),
              _buildDayEventsSection(context: context),
              _buildRecurringEventsSection(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionBase({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          AppDimensions.containerBorderRadius,
        ),
      ),
      margin: const EdgeInsets.only(top: AppDimensions.marginLarge),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingTiny,
        vertical: AppDimensions.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.paddingSmall),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: AppDimensions.iconSizeMedium,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                HorizontalGap.tiny(),
                AppText(text: title, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildTasksSection({required BuildContext context}) {
    if (tasks.isEmpty) {
      return SizedBox.shrink();
    }

    return _sectionBase(
      context: context,
      icon: Icons.checklist_rtl,
      title: WeekViewTranslations.tasksSectionTitle,
      child: ListView.separated(
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
      ),
    );
  }

  Widget _buildDayEventsSection({required BuildContext context}) {
    if (events.isEmpty) {
      return SizedBox.shrink();
    }

    return _sectionBase(
      context: context,
      icon: Icons.event,
      title: WeekViewTranslations.dayEventsSectionTitle,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: events.length,
        separatorBuilder: (_, index) => VerticalGap.small(),
        itemBuilder: (_, index) {
          final event = events[index];

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
      ),
    );
  }

  Widget _buildRecurringEventsSection({required BuildContext context}) {
    if (recurringEvents.isEmpty) {
      return SizedBox.shrink();
    }

    return _sectionBase(
      context: context,
      icon: Icons.repeat,
      title: WeekViewTranslations.recurringEventsSectionTitle,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: recurringEvents.length,
        separatorBuilder: (_, index) => VerticalGap.small(),
        itemBuilder: (_, index) {
          final event = recurringEvents[index];

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
      ),
    );
  }
}
