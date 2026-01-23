import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_day_widget.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/utils/task_utils.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class WeekViewWidget extends ConsumerWidget {
  WeekViewWidget({super.key});

  final int _daysInWeek = 7;
  final TasksController _tasksController = serviceLocator
      .get<TasksController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final weekTasksAsync = ref.watch(_tasksController.weekTasksProvider);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
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
          weekTasksAsync.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, _) {
              return Center(child: Text('Error: $error'));
            },
            data: (tasks) {
              return _buildWeekDays(context: context, tasks: tasks, ref: ref);
            },
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
      ],
    );
  }

  Widget _buildWeekDays({
    required BuildContext context,
    required List<TaskEntity> tasks,
    required WidgetRef ref,
  }) {
    final tasksByDay = TaskUtils.groupTasksByDay(tasks);
    final daysOfTheWeek = DateTime.now().getDaysOfTheWeek();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_daysInWeek, (index) {
          final date = daysOfTheWeek[index];
          final tasks = tasksByDay[date] ?? [];
          final weekday = Weekday.values[index];

          return Flexible(
            child: WeekViewDayWidget(
              title: WeekdayTranslations.getWeekDayNameByIndex(index + 1),
              date: date,
              weekday: weekday,
              tasks: tasks,
              onTaskDelete: (taskId) {
                _deleteTask(taskId: taskId, ref: ref);
              },
              onTaskComplete: (taskId) =>
                  _completeTask(taskId: taskId, ref: ref),
              onSave: () => _refreshWeekView(ref: ref),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _deleteTask({
    required String taskId,
    required WidgetRef ref,
  }) async {
    await _tasksController.deleteTask(taskId: taskId);
    ref.invalidate(_tasksController.weekTasksProvider);
  }

  Future<void> _completeTask({
    required String taskId,
    required WidgetRef ref,
  }) async {
    await _tasksController.completeTask(taskId: taskId);
    ref.invalidate(_tasksController.weekTasksProvider);
  }

  void _refreshWeekView({required WidgetRef ref}) {
    ref.invalidate(_tasksController.weekTasksProvider);
  }
}
