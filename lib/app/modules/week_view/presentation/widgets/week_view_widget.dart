import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/utils/event_utils.dart';
import 'package:personal_planner/app/modules/events/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/add_event_dialog.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_day_widget.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/utils/task_utils.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/e_weekday.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class WeekViewWidget extends ConsumerWidget {
  WeekViewWidget({super.key});

  final int _daysInWeek = 7;
  final EventController _eventController = serviceLocator
      .get<EventController>();
  final TasksController _tasksController = serviceLocator
      .get<TasksController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final weekDateRange = ref.watch(
      _eventController.currentWeekDateRangeProvider,
    );
    final weekEventsAsync = ref.watch(
      _eventController.weekEventsProvider(weekDateRange),
    );
    final weekTasksAsync = ref.watch(_tasksController.weekTasksProvider);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      width: AppDimensions.weekViewWidthRatio * screenWidth,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(
          AppDimensions.containerBorderRadius,
        ),
      ),
      child: Column(
        children: [
          _buildHeader(theme: theme, ref: ref),
          const VerticalGap.medium(),
          Expanded(
            child: weekEventsAsync.when(
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, _) {
                return Center(child: Text('Error: $error'));
              },
              data: (events) {
                return weekTasksAsync.when(
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  error: (error, _) {
                    return Center(child: Text('Error: $error'));
                  },
                  data: (tasks) {
                    return _buildWeekDays(
                      context: context,
                      events: events,
                      tasks: tasks,
                      ref: ref,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required ThemeData theme, required WidgetRef ref}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: WeekViewTranslations.title,
          color: theme.colorScheme.onPrimaryContainer,
          style: theme.textTheme.titleMedium,
        ),
        const Spacer(),
        AppIconButton(
          iconData: Icons.refresh_outlined,
          color: theme.colorScheme.onPrimaryContainer,
          onPressed: () {
            _refreshWeekView(ref: ref);
          },
        ),
        HorizontalGap.small(),
        AppIconButton(
          iconData: Icons.add_circle_outline_outlined,
          color: theme.colorScheme.onPrimaryContainer,
          onPressed: () {
            _showAddEventDialog(ref: ref, context: ref.context);
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays({
    required BuildContext context,
    required List<EventEntity> events,
    required List<TaskEntity> tasks,
    required WidgetRef ref,
  }) {
    final eventsByDay = EventUtils.groupEventsByDay(events);
    final tasksByDay = TaskUtils.groupTasksByDay(tasks);
    final daysOfTheWeek = DateTime.now().getDaysOfTheWeek();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_daysInWeek, (index) {
                final date = daysOfTheWeek[index];
                final events = eventsByDay[date] ?? [];
                final tasks = tasksByDay[date] ?? [];
                final weekday = EWeekday.values[index];

                return WeekViewDayWidget(
                  title: WeekdayTranslations.getWeekDayNameByIndex(index),
                  date: date,
                  weekday: weekday,
                  events: events,
                  tasks: tasks,
                  onEventDelete: (eventId) =>
                      _deleteEvent(eventId: eventId, ref: ref),
                  onTaskComplete: (taskId) =>
                      _completeTask(taskId: taskId, ref: ref),
                  onTapAddEvent: () => _showAddEventDialog(
                    ref: ref,
                    context: context,
                    initialDate: date,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddEventDialog({
    required WidgetRef ref,
    required BuildContext context,
    DateTime? initialDate,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: AddEventDialog(
            initialDate: initialDate,
            onEventAdded: () => _onEventAdded(ref),
          ),
        );
      },
    );
  }

  Future<void> _deleteEvent({
    required String eventId,
    required WidgetRef ref,
  }) async {
    await _eventController.deleteEvent(eventId: eventId);
    ref.invalidate(_eventController.weekEventsProvider);
  }

  void _onEventAdded(WidgetRef ref) {
    ref.invalidate(_eventController.weekEventsProvider);
  }

  Future<void> _completeTask({
    required String taskId,
    required WidgetRef ref,
  }) async {
    await _tasksController.completeTask(taskId: taskId);
    ref.invalidate(_tasksController.weekTasksProvider);
  }

  void _refreshWeekView({required WidgetRef ref}) {
    ref.invalidate(_eventController.weekEventsProvider);
    ref.invalidate(_tasksController.weekTasksProvider);
  }
}
