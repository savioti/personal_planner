import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingSmall,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: task.title,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        Divider(
                          thickness:
                              AppDimensions.weekViewItemUnderlineThickness,
                          height: AppDimensions.weekViewItemUnderlineThickness,
                          color: isHovering
                              ? theme.primaryColor
                              : theme.dividerColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isHovering)
                AppIconButton(
                  iconData: task.isDone
                      ? Icons.cancel_outlined
                      : Icons.check_circle_outline,
                  color: theme.primaryColor,
                  onPressed: onComplete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
