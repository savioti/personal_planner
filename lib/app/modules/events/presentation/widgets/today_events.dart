import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/utils/event_utils.dart';
import 'package:personal_planner/app/modules/events/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/modules/upcoming_events/presentation/widgets/event_widget.dart';
import 'package:personal_planner/app/modules/week_view/presentation/widgets/event_form_dialog.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class TodayEventsWidget extends ConsumerWidget {
  TodayEventsWidget({super.key});

  final _eventController = serviceLocator.get<EventController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final weekDateRange = ref.watch(
      _eventController.currentWeekDateRangeProvider,
    );
    final weekEventsAsync = ref.watch(
      _eventController.weekEventsProvider(weekDateRange),
    );

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(
          AppDimensions.containerBorderRadius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context: context, ref: ref),
          const SizedBox(height: AppDimensions.spacingSmall),
          weekEventsAsync.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, _) {
              return Center(child: AppText(text: 'Error: $error'));
            },
            data: (events) {
              return Expanded(
                child: _buildTodayEventsList(
                  context: context,
                  ref: ref,
                  theme: theme,
                  events: events,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required BuildContext context, required WidgetRef ref}) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
          text: TodayEventsTranslations.title,
          color: theme.colorScheme.onPrimaryContainer,
          style: theme.textTheme.titleMedium,
        ),
        const Spacer(),
        AppIconButton(
          iconData: Icons.refresh_outlined,
          color: theme.colorScheme.onPrimaryContainer,
          onPressed: () {
            _refreshEvents(ref: ref);
          },
        ),
        HorizontalGap.small(),
        AppIconButton(
          iconData: Icons.add_circle_outline_outlined,
          color: theme.colorScheme.onPrimaryContainer,
          onPressed: () {
            _showAddEventDialog(
              ref: ref,
              context: ref.context,
              initialDate: DateTime.now().roundToNearestQuarterHour,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTodayEventsList({
    required WidgetRef ref,
    required ThemeData theme,
    required List<EventEntity> events,
    required BuildContext context,
  }) {
    final eventsByDay = EventUtils.groupEventsByDay(events);
    final dayEvents = eventsByDay[DateTime.now().toDateOnly] ?? [];
    final sortedEvents = List<EventEntity>.from(dayEvents)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    if (sortedEvents.isEmpty) {
      return Expanded(
        child: Center(
          child: AppText(
            text: TodayEventsTranslations.noEvents,
            color: theme.colorScheme.onPrimaryContainer,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    }

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sortedEvents.length,
      separatorBuilder: (_, index) => VerticalGap.small(),
      itemBuilder: (_, index) {
        final event = sortedEvents[index];

        return EventWidget(
          event: event,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: EventFormDialog(
                    event: event,
                    onSave: () => _refreshEvents(ref: ref),
                    onDelete: () => _deleteEvent(eventId: event.id, ref: ref),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _showAddEventDialog({
    required WidgetRef ref,
    required BuildContext context,
    DateTime? initialDate,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: EventFormDialog(
            initialDate: initialDate,
            onSave: () => _refreshEvents(ref: ref),
          ),
        );
      },
    );
  }

  void _refreshEvents({required WidgetRef ref}) {
    ref.invalidate(_eventController.weekEventsProvider);
    ref.invalidate(_eventController.thisWeekEventsProvider);
    ref.invalidate(_eventController.nextWeekEventsProvider);
    ref.invalidate(_eventController.futureEventsProvider);
  }

  Future<void> _deleteEvent({
    required String eventId,
    required WidgetRef ref,
  }) async {
    await _eventController.deleteEvent(eventId: eventId);
    _refreshEvents(ref: ref);
  }
}
