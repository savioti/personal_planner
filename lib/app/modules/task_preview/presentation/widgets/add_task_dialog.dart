import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_main_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_date_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_time_text_field.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class AddTaskDialog extends StatefulWidget {
  final VoidCallback onTaskAdded;

  const AddTaskDialog({super.key, required this.onTaskAdded});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _tasksController = serviceLocator.get<TasksController>();

  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _deadlineDateTextController = TextEditingController();
  final _deadlineTimeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFieldsWithDefaultValues();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    _deadlineDateTextController.dispose();
    _deadlineTimeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      constraints: BoxConstraints(maxWidth: AppDimensions.dialogMaxWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.dialogBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(theme: theme),
          const VerticalGap(),
          _buildTextFields(theme: theme),
          const VerticalGap.large(),
          _buildActionButtons(context: context),
        ],
      ),
    );
  }

  Widget _buildTitle({required ThemeData theme}) {
    return AppText(
      text: WeekTasksTranslations.dialogTitle,
      color: theme.colorScheme.onPrimaryContainer,
      style: theme.textTheme.displaySmall,
    );
  }

  Widget _buildTextFields({required ThemeData theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: WeekTasksTranslations.taskTitle,
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(child: AppTextField(controller: _titleTextController)),
          ],
        ),
        const VerticalGap.small(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: WeekTasksTranslations.taskDescription,
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(
              child: AppTextField(controller: _descriptionTextController),
            ),
          ],
        ),
        const VerticalGap.small(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: WeekTasksTranslations.taskDeadline,
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(
              child: AppDateTextField(controller: _deadlineDateTextController),
            ),
          ],
        ),
        const VerticalGap.small(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: WeekViewTranslations.eventTime,
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(
              child: AppTimeTextField(controller: _deadlineTimeTextController),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AppMainButton(
            labelText: WeekTasksTranslations.taskDiscard,
            buttonType: EButtonType.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const HorizontalGap.medium(),
        Expanded(
          child: AppMainButton(
            labelText: WeekTasksTranslations.taskSave,
            onPressed: () => _saveTask(context: context),
          ),
        ),
      ],
    );
  }

  void _saveTask({required BuildContext context}) async {
    final title = _titleTextController.text;
    final description = _descriptionTextController.text;
    final deadlineText = _deadlineDateTextController.text;

    DateTime? deadline;
    if (deadlineText.isNotEmpty) {
      final splitDate = deadlineText.split('-');

      if (splitDate.length == 3) {
        final year = int.tryParse(splitDate[0]);
        final month = int.tryParse(splitDate[1]);
        final day = int.tryParse(splitDate[2]);

        if (year != null && month != null && day != null) {
          deadline = DateTime(year, month, day);
        }
      }

      final timeText = _deadlineTimeTextController.text;

      if (timeText.isNotEmpty) {
        final splitTime = timeText.split(':');

        if (splitTime.length == 2) {
          final hour = int.tryParse(splitTime[0]);
          final minute = int.tryParse(splitTime[1]);

          if (hour != null && minute != null && deadline != null) {
            deadline = DateTime(
              deadline.year,
              deadline.month,
              deadline.day,
              hour,
              minute,
            );
          }
        }
      }
    }

    final result = await _tasksController.addTask(
      title: title,
      description: description.isNotEmpty ? description : null,
      deadline: deadline,
    );

    if (result.isLeft()) {
      return;
    }

    widget.onTaskAdded();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _initFieldsWithDefaultValues() {
    final now = DateTime.now();
    _deadlineDateTextController.text =
        '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    _deadlineTimeTextController.text =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
