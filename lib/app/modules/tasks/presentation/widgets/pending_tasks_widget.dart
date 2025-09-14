import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/modules/tasks/presentation/widgets/add_task_dialog.dart';
import 'package:personal_planner/app/modules/tasks/presentation/widgets/task_widget.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class PendingTasksWidget extends ConsumerWidget {
  PendingTasksWidget({super.key});

  final TasksController _controller = serviceLocator.get<TasksController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final weekEventsAsync = ref.watch(_controller.tasksProvider);

    return Container(
      width: AppDimensions.weekTasksWidthRatio * screenWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context: context, ref: ref),
          const SizedBox(height: AppDimensions.spacingSmall),
          weekEventsAsync.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, _) {
              return Center(child: Text('Error: $error'));
            },
            data: (tasks) {
              return Expanded(
                child: ListView.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimensions.spacingSmall),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskWidget(task: task);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required BuildContext context, required WidgetRef ref}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: WeekTasksTranslations.title,
          color: Theme.of(context).colorScheme.onPrimary,
          style: AppTextStyles.titleMedium(),
        ),
        AppIconButton(
          iconData: Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: AddTaskDialog(
                    onTaskAdded: () => _onTaskAdded(ref: ref),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _onTaskAdded({required WidgetRef ref}) {
    ref.invalidate(_controller.tasksProvider);
  }
}
