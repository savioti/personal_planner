import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/add_task_dialog.dart';
import 'package:personal_planner/app/modules/task_preview/presentation/widgets/task_widget.dart';
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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: AppDimensions.weekTasksWidthRatio * screenWidth,
      height: double.maxFinite,
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(
          AppDimensions.containerBorderRadius,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context: context, ref: ref),
            const SizedBox(height: AppDimensions.spacingSmall),
            _buildOverdueTasksList(ref: ref, theme: theme),
            const SizedBox(height: AppDimensions.spacingMedium),
            _buildWeekTasksList(ref: ref, theme: theme),
            const SizedBox(height: AppDimensions.spacingMedium),
            _buildBacklogTasksList(ref: ref, theme: theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({required BuildContext context, required WidgetRef ref}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: WeekTasksTranslations.title,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          style: AppTextStyles.titleMedium(),
        ),
        AppIconButton(
          iconData: Icons.add_circle_outline_outlined,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
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

  Widget _buildOverdueTasksList({
    required WidgetRef ref,
    required ThemeData theme,
  }) {
    final overdueTasksAsync = ref.watch(_controller.overdueTasksProvider);

    return overdueTasksAsync.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, _) {
        return Center(child: Text('Error: $error'));
      },
      data: (tasks) {
        if (tasks.isEmpty) {
          return const SizedBox();
        }

        return Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              AppDimensions.containerBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: WeekTasksTranslations.overdueTasksTitle,
                color: theme.colorScheme.onPrimaryContainer,
                style: AppTextStyles.titleSmall(),
              ),
              const SizedBox(height: AppDimensions.spacingSmall),
              ListView.separated(
                itemCount: tasks.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimensions.spacingSmall),
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return TaskWidget(
                    task: task,
                    onComplete: (_) => _onCompleteChanged(ref: ref),
                    onDelete: (_) => _onDeletePressed(ref: ref),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeekTasksList({
    required WidgetRef ref,
    required ThemeData theme,
  }) {
    final weekTasksAsync = ref.watch(_controller.weekTasksProvider);

    return weekTasksAsync.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, _) {
        return Center(child: Text('Error: $error'));
      },
      data: (tasks) {
        if (tasks.isEmpty) {
          return const SizedBox();
        }

        return Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              AppDimensions.containerBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: WeekTasksTranslations.thisWeekTasksTitle,
                color: theme.colorScheme.onPrimaryContainer,
                style: AppTextStyles.titleSmall(),
              ),
              const SizedBox(height: AppDimensions.spacingSmall),
              ListView.separated(
                itemCount: tasks.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimensions.spacingSmall),
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return TaskWidget(
                    task: task,
                    onComplete: (_) => _onCompleteChanged(ref: ref),
                    onDelete: (_) => _onDeletePressed(ref: ref),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBacklogTasksList({
    required WidgetRef ref,
    required ThemeData theme,
  }) {
    final backlogTasksAsync = ref.watch(_controller.backlogTasksProvider);

    return backlogTasksAsync.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, _) {
        return Center(child: Text('Error: $error'));
      },
      data: (tasks) {
        if (tasks.isEmpty) {
          return const SizedBox();
        }

        return Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              AppDimensions.containerBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: WeekTasksTranslations.backlogTasksTitle,
                color: theme.colorScheme.onPrimaryContainer,
                style: AppTextStyles.titleSmall(),
              ),
              const SizedBox(height: AppDimensions.spacingSmall),
              ListView.separated(
                itemCount: tasks.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimensions.spacingSmall),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskWidget(
                    task: task,
                    onComplete: (_) => _onCompleteChanged(ref: ref),
                    onDelete: (_) => _onDeletePressed(ref: ref),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onTaskAdded({required WidgetRef ref}) {
    ref.invalidate(_controller.weekTasksProvider);
    ref.invalidate(_controller.backlogTasksProvider);
    ref.invalidate(_controller.overdueTasksProvider);
  }

  void _onCompleteChanged({required WidgetRef ref}) {
    ref.invalidate(_controller.weekTasksProvider);
  }

  void _onDeletePressed({required WidgetRef ref}) {
    ref.invalidate(_controller.weekTasksProvider);
  }
}
