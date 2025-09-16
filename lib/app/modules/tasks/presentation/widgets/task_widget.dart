import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/checkbox/app_checkbox.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class TaskWidget extends StatelessWidget {
  final TaskEntity task;
  final Function(String eventId) onComplete;

  const TaskWidget({super.key, required this.task, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          AppDimensions.weekViewEventBorderRadius,
        ),
      ),
      child: Row(
        children: [
          _buildCheckbox(colorScheme: theme.colorScheme),
          const SizedBox(width: AppDimensions.spacingSmall),
          Expanded(
            child: AppText(
              text: task.title,
              color: theme.colorScheme.onPrimary,
              style: AppTextStyles.bodySmallBold(),
            ),
          ),
          _buildDeadline(),
        ],
      ),
    );
  }

  Widget _buildCheckbox({required ColorScheme colorScheme}) {
    return AppCheckbox(
      value: task.isDone,
      onChanged: (_) => _onCompleteChanged(),
    );
  }

  Widget _buildDeadline() {
    if (task.deadline == null) {
      return const SizedBox();
    }

    return AppText(text: task.deadline!.toHumanReadableNextDate);
  }

  void _onCompleteChanged() async {
    final taskId = task.id;
    await serviceLocator.get<TasksController>().completeTask(taskId: taskId);
    onComplete(taskId);
  }
}
