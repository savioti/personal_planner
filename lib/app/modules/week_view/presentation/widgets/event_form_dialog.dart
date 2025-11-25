import 'package:flutter/material.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/button/app_main_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_date_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_text_field.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_time_text_field.dart';
import 'package:personal_planner/app/shared/enums/recurrence_type.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class EventFormDialog extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final EventEntity? event;
  final DateTime? initialDate;

  const EventFormDialog({
    super.key,
    required this.onSave,
    this.onDelete,
    this.event,
    this.initialDate,
  });

  @override
  State<EventFormDialog> createState() => _EventFormDialogState();
}

class _EventFormDialogState extends State<EventFormDialog> {
  final _selectedWeekdays = <Weekday>{};
  RecurrenceType _selectedRecurrenceType = RecurrenceType.none;

  final _eventController = serviceLocator.get<EventController>();

  final _eventTitleTextController = TextEditingController();
  final _eventDateTextController = TextEditingController();
  final _eventTimeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFields();
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
                _buildHeader(theme: theme),
                _buildTextFields(),
                const VerticalGap.large(),
                _buildRecurrenceTypeSelector(theme: theme),
                _buildWeekdaySelector(theme: theme),
                const VerticalGap.extraLarge(),
                _buildActionButtons(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({required ThemeData theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.event != null && widget.onDelete != null)
          AppIconButton(
            iconData: Icons.delete,
            color: theme.colorScheme.primary,
            onPressed: () {
              widget.onDelete?.call();
              Navigator.of(context).pop();
            },
          ),
        AppIconButton(
          iconData: Icons.close,
          color: theme.colorScheme.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
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

  Widget _buildRecurrenceTypeSelector({required ThemeData theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: '${WeekViewTranslations.eventRecurrence}:',
          style: AppTextStyles.bodyMedium(),
        ),
        const HorizontalGap.medium(),
        DropdownButton<RecurrenceType>(
          value: _selectedRecurrenceType,
          items: RecurrenceType.values.map((RecurrenceType type) {
            return DropdownMenuItem<RecurrenceType>(
              value: type,
              child: AppText(
                text: RecurrenceTypeTranslations.getRecurrenceTypeName(type),
              ),
            );
          }).toList(),
          onChanged: (RecurrenceType? newValue) {
            _onUpdateRecurrenceType(newValue);
          },
        ),
      ],
    );
  }

  Widget _buildWeekdaySelector({required ThemeData theme}) {
    if (_selectedRecurrenceType == RecurrenceType.daily ||
        _selectedRecurrenceType == RecurrenceType.none ||
        _selectedRecurrenceType == RecurrenceType.yearly ||
        _selectedRecurrenceType == RecurrenceType.monthly) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.spacingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: Weekday.values.map((weekday) {
          final isSelected = _selectedWeekdays.contains(weekday);

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                _onWeekdayChipTap(weekday);
              },
              child: Container(
                width: AppDimensions.weekViewweekdayChipSize,
                height: AppDimensions.weekViewweekdayChipSize,
                padding: const EdgeInsets.all(AppDimensions.paddingTiny),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.weekViewweekdayChipRadius,
                  ),
                ),
                child: Center(
                  child: AppText(
                    text: WeekdayTranslations.getWeekdayFirstLetterByIndex(
                      weekday.toInt(),
                    ),
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButtons({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AppMainButton(
            labelText: WeekViewTranslations.eventFormCancel,
            buttonType: EButtonType.secondary,
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ),
        const HorizontalGap.medium(),
        Expanded(
          child: AppMainButton(
            labelText: WeekViewTranslations.eventSave,
            onPressed: () {
              _saveEvent(context: context);
            },
          ),
        ),
      ],
    );
  }

  void _saveEvent({required BuildContext context}) async {
    final title = _eventTitleTextController.text;
    final date = _parseCurrentDate();

    if (date == null) {
      return;
    }

    final time = _eventTimeTextController.text;
    final splitTime = time.split(':');

    if (splitTime.length != 2) {
      return;
    }

    final hour = splitTime[0];
    final minute = splitTime[1];

    if (widget.event != null) {
      await _updateEvent(
        context: context,
        title: title,
        year: date.year,
        month: date.month,
        day: date.day,
        hour: hour,
        minute: minute,
      );
      return;
    }

    await _addEvent(
      context: context,
      title: title,
      year: date.year,
      month: date.month,
      day: date.day,
      hour: hour,
      minute: minute,
    );
  }

  Future<void> _updateEvent({
    required BuildContext context,
    required String title,
    required int? year,
    required int? month,
    required int? day,
    required String hour,
    required String minute,
  }) async {
    final result = await _eventController.editEvent(
      eventId: widget.event!.id,
      title: title,
      startTime: DateTime(
        year ?? 0,
        month ?? 0,
        day ?? 0,
        int.tryParse(hour) ?? 0,
        int.tryParse(minute) ?? 0,
      ),
      recurrenceType: _selectedRecurrenceType,
      recurrenceWeekdays: _selectedWeekdays,
    );

    if (result.isLeft()) {
      return;
    }

    widget.onSave();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _addEvent({
    required BuildContext context,
    required String title,
    required int? year,
    required int? month,
    required int? day,
    required String hour,
    required String minute,
  }) async {
    final result = await _eventController.addEvent(
      title: title,
      startTime: DateTime(
        year ?? 0,
        month ?? 0,
        day ?? 0,
        int.tryParse(hour) ?? 0,
        int.tryParse(minute) ?? 0,
      ),
      recurrenceType: _selectedRecurrenceType,
      recurrenceWeekdays: _selectedWeekdays,
    );

    if (result.isLeft()) {
      return;
    }

    widget.onSave();

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _initFields() {
    final now = DateTime.now().roundToNearestQuarterHour;
    final targetDate =
        widget.event?.startTime ??
        widget.initialDate?.roundToNearestQuarterHour ??
        now;

    _eventTitleTextController.text = widget.event?.title ?? '';
    _eventDateTextController.text =
        '${targetDate.year.toString().padLeft(4, '0')}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}';
    _eventTimeTextController.text =
        '${targetDate.hour.toString().padLeft(2, '0')}:${targetDate.minute.toString().padLeft(2, '0')}';

    if (widget.event != null && widget.event!.recurrenceType != null) {
      _selectedRecurrenceType = widget.event!.recurrenceType!;

      if (widget.event!.recurrenceWeekdays != null) {
        _selectedWeekdays.addAll(widget.event!.recurrenceWeekdays!);
      }
    }
  }

  void _onUpdateRecurrenceType(RecurrenceType? newValue) {
    setState(() {
      if (newValue == null) {
        return;
      }

      _selectedWeekdays.clear();
      _selectedRecurrenceType = newValue;

      if (_selectedRecurrenceType == RecurrenceType.weekly ||
          _selectedRecurrenceType == RecurrenceType.firstWeekdayOfTheMonth) {
        final selectedDate = _parseCurrentDate() ?? DateTime.now();
        final weekday = Weekday.fromInt(selectedDate.weekday);
        _selectedWeekdays.add(weekday);
      }
    });
  }

  void _onWeekdayChipTap(Weekday weekday) {
    setState(() {
      final isSelected = _selectedWeekdays.contains(weekday);

      if (isSelected) {
        if (_selectedRecurrenceType != RecurrenceType.firstWeekdayOfTheMonth) {
          _selectedWeekdays.remove(weekday);
        }
      } else {
        if (_selectedRecurrenceType == RecurrenceType.firstWeekdayOfTheMonth) {
          _selectedWeekdays.clear();
        }

        _selectedWeekdays.add(weekday);
      }
    });
  }

  DateTime? _parseCurrentDate() {
    final date = _eventDateTextController.text;

    final splitDate = date.split('-');

    if (splitDate.length != 3) {
      return null;
    }

    final year = int.tryParse(splitDate[0]);
    final month = int.tryParse(splitDate[1]);
    final day = int.tryParse(splitDate[2]);

    return DateTime(year ?? 0, month ?? 0, day ?? 0);
  }
}
