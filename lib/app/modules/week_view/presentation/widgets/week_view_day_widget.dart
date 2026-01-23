import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/task_form_dialog.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/week_view_day_title_divider_widget.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/task_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class WeekViewDayWidget extends StatelessWidget {
  final String title;
  final Weekday weekday;
  final DateTime date;
  final List<TaskEntity> tasks;
  final Function(String taskId) onTaskDelete;
  final VoidCallback onSave;
  final Function(String taskId) onTaskComplete;

  const WeekViewDayWidget({
    super.key,
    required this.title,
    required this.weekday,
    required this.date,
    required this.tasks,
    required this.onTaskDelete,
    required this.onSave,
    required this.onTaskComplete,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toDateOnly;
    final theme = Theme.of(context);

    return Opacity(
      opacity: date.toDateOnly.isBefore(now) ? 0.5 : 1.0,
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
                child: Column(children: [_buildTasksSection(context: context)]),
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
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingTiny),
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
}
