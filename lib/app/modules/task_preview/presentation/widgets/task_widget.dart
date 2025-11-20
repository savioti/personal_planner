import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/task_form_dialog.dart';
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
  final Function(String eventId) onDelete;
  final VoidCallback onSave;

  const TaskWidget({
    super.key,
    required this.task,
    required this.onComplete,
    required this.onDelete,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          AppDimensions.weekViewEventBorderRadius,
        ),
      ),
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              _buildCheckbox(),
              const SizedBox(width: AppDimensions.spacingSmall),
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: TaskFormDialog(
                              task: task,
                              onSave: onSave,
                              onDelete: () => onDelete(task.id),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: task.title,
                            color: theme.colorScheme.onPrimary,
                            style: AppTextStyles.bodySmallBold(),
                          ),
                        ),
                        _buildDeadline(theme: theme),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCheckbox() {
    return AppCheckbox(
      value: task.isDone,
      onChanged: (_) => _onCompleteChanged(),
    );
  }

  Widget _buildDeadline({required ThemeData theme}) {
    if (task.deadline == null) {
      return const SizedBox();
    }

    return AppText(
      text: task.deadline!.toHumanReadableNextDate,
      color: theme.colorScheme.onPrimary,
      style: AppTextStyles.bodySmall(),
    );
  }

  void _onCompleteChanged() async {
    final taskId = task.id;
    await serviceLocator.get<TasksController>().completeTask(taskId: taskId);
    onComplete(taskId);
  }
}
