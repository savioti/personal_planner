import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/event/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_main_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_date_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_time_text_field.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class WeekViewAddEventDialog extends StatefulWidget {
  final VoidCallback onEventAdded;

  const WeekViewAddEventDialog({super.key, required this.onEventAdded});

  @override
  State<WeekViewAddEventDialog> createState() => _WeekViewAddEventDialogState();
}

class _WeekViewAddEventDialogState extends State<WeekViewAddEventDialog> {
  final _eventController = serviceLocator.get<EventController>();

  final _eventTitleTextController = TextEditingController();
  final _eventDateTextController = TextEditingController();
  final _eventTimeTextController = TextEditingController();

  @override
  void dispose() {
    _eventTitleTextController.dispose();
    _eventDateTextController.dispose();
    _eventTimeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: AppDimensions.dialogMaxWidth),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.cardPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimensions.dialogBorderRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: AppDimensions.dialogBorderWidth,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            const VerticalGap(),
            _buildTextFields(),
            const VerticalGap.large(),
            _buildActionButtons(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    final tr = serviceLocator.get<TranslationsController>();

    return AppText(
      text: tr('week_view.add_event_dialog.dialog_title'),
      style: AppTextStyles.displaySmall(),
    );
  }

  Widget _buildTextFields() {
    final tr = serviceLocator.get<TranslationsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: '${tr('week_view.add_event_dialog.event_title')}:',
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
              text: '${tr('week_view.add_event_dialog.event_date')}:',
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
              text: '${tr('week_view.add_event_dialog.event_time')}:',
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
    final tr = serviceLocator.get<TranslationsController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AppMainButton(
            labelText: tr('week_view.add_event_dialog.event_discard'),
            buttonType: EButtonType.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const HorizontalGap.medium(),
        Expanded(
          child: AppMainButton(
            labelText: tr('week_view.add_event_dialog.event_save'),
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
    final minute = splitTime[1].split('')[0];

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
}
