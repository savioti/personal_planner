import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/events/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_main_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_date_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_time_text_field.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class AddEventDialog extends StatefulWidget {
  final VoidCallback onEventAdded;
  final DateTime? initialDate;

  const AddEventDialog({
    super.key,
    required this.onEventAdded,
    this.initialDate,
  });

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _eventController = serviceLocator.get<EventController>();

  final _eventTitleTextController = TextEditingController();
  final _eventDateTextController = TextEditingController();
  final _eventTimeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFieldsWithDefaultValues();
  }

  @override
  void dispose() {
    _eventTitleTextController.dispose();
    _eventDateTextController.dispose();
    _eventTimeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: AppDimensions.dialogMaxWidth),
      child: IntrinsicHeight(
        child: Dialog(
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.cardPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.dialogBorderRadius,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(theme: theme),
                const VerticalGap(),
                _buildTextFields(),
                const VerticalGap.large(),
                _buildActionButtons(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle({required ThemeData theme}) {
    return AppText(
      text: WeekViewTranslations.dialogTitle,
      color: theme.colorScheme.onPrimaryContainer,
      style: theme.textTheme.displaySmall,
    );
  }

  Widget _buildTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: '${WeekViewTranslations.eventTitle}:',
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(
              child: AppTextField(controller: _eventTitleTextController),
            ),
          ],
        ),
        const VerticalGap.small(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: '${WeekViewTranslations.eventDate}:',
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(
              child: AppDateTextField(controller: _eventDateTextController),
            ),
          ],
        ),
        const VerticalGap.small(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: '${WeekViewTranslations.eventTime}:',
              style: AppTextStyles.bodyMedium(),
            ),
            const HorizontalGap.small(),
            Expanded(
              child: AppTimeTextField(controller: _eventTimeTextController),
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
            labelText: WeekViewTranslations.eventDiscard,
            buttonType: EButtonType.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const HorizontalGap.medium(),
        Expanded(
          child: AppMainButton(
            labelText: WeekViewTranslations.eventSave,
            onPressed: () => _saveEvent(context: context),
          ),
        ),
      ],
    );
  }

  void _saveEvent({required BuildContext context}) async {
    final title = _eventTitleTextController.text;
    final date = _eventDateTextController.text;
    final time = _eventTimeTextController.text;

    final splitDate = date.split('-');

    if (splitDate.length != 3) {
      return;
    }

    final year = int.tryParse(splitDate[0]);
    final month = int.tryParse(splitDate[1]);
    final day = int.tryParse(splitDate[2]);

    final splitTime = time.split(':');
    final hour = splitTime[0];
    final minute = splitTime[1];

    final result = await _eventController.addEvent(
      title: title,
      startTime: DateTime(
        year ?? 0,
        month ?? 0,
        day ?? 0,
        int.tryParse(hour) ?? 0,
        int.tryParse(minute) ?? 0,
      ),
    );

    if (result.isLeft()) {
      return;
    }

    widget.onEventAdded();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _initFieldsWithDefaultValues() {
    final now = DateTime.now().roundToNearestQuarterHour;
    final targetDate = widget.initialDate?.roundToNearestQuarterHour ?? now;

    _eventDateTextController.text =
        '${targetDate.year.toString().padLeft(4, '0')}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}';
    _eventTimeTextController.text =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
