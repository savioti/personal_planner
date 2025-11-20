import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/checkbox/app_checkbox.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';

class TaskWidget extends ConsumerWidget {
  final TaskEntity task;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;

  TaskWidget({super.key, required this.task, this.onTap, this.onComplete});

  final hoveringProvider = StateProvider.autoDispose<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isHovering = ref.watch(hoveringProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => ref.read(hoveringProvider.notifier).state = true,
      onExit: (_) => ref.read(hoveringProvider.notifier).state = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHovering ? theme.highlightColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
        ),
        child: SizedBox(
          height: AppDimensions.weekViewTaskItemHeight,
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                _buildCheckbox(theme: theme),
                const SizedBox(width: AppDimensions.spacingTiny),
                Expanded(
                  child: AppText(
                    text: task.title,
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox({required ThemeData theme}) {
    return AppCheckbox(
      value: task.isDone,
      fillColor: Colors.transparent,
      checkColor: theme.primaryColor,
      borderColor: theme.primaryColor,
      onChanged: (_) => _onCompleteChanged(),
    );
  }

  void _onCompleteChanged() async {
    final taskId = task.id;
    await serviceLocator.get<TasksController>().completeTask(taskId: taskId);
    onComplete?.call();
  }
}
