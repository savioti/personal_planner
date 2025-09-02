import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/domain/utils/event_utils.dart';
import 'package:personal_planner/app/modules/event/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_add_event_dialog.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_day_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/e_weekday.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class WeekviewWidget extends ConsumerWidget {
  WeekviewWidget({super.key});

  final int daysInWeek = 7;
  final EventController controller = serviceLocator.get<EventController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final weekDateRange = ref.watch(controller.currentWeekDateRangeProvider);
    final weekEventsAsync = ref.watch(
      controller.weekEventsProvider(weekDateRange),
    );

    return Container(
      width: AppDimensions.weekViewWidthRatio * screenWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      child: Column(
        children: [
          _buildHeader(context: context, ref: ref),
          const VerticalGap.small(),
          Expanded(
            child: weekEventsAsync.when(
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, stack) {
                return Center(child: Text('Error: $error'));
              },
              data: (events) {
                return _buildWeekDays(
                  context: context,
                  events: events,
                  ref: ref,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required BuildContext context, required WidgetRef ref}) {
    final tr = serviceLocator.get<TranslationsController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: tr('week_view.title'),
          style: AppTextStyles.titleMedium(),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: WeekViewAddEventDialog(
                    onEventAdded: () => _onEventAdded(ref),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekDays({
    required BuildContext context,
    required List<EventEntity> events,
    required WidgetRef ref,
  }) {
    final tr = serviceLocator.get<TranslationsController>();
    final eventsByDay = EventUtils.groupEventsByDay(events);
    final daysOfTheWeek = EventUtils.getDaysOfTheWeek(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(daysInWeek, (index) {
                final date = daysOfTheWeek[index];
                final events = eventsByDay[date] ?? [];
                final weekday = EWeekday.values[index];
                final weekdayKey = weekday.toString();

                return WeekviewDayWidget(
                  title: tr('weekday.$weekdayKey'),
                  weekday: weekday,
                  events: events,
                  onDelete: (eventId) =>
                      _deleteEvent(eventId: eventId, ref: ref),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _deleteEvent({
    required String eventId,
    required WidgetRef ref,
  }) async {
    await controller.deleteEvent(eventId: eventId);
    ref.invalidate(controller.weekEventsProvider);
  }

  void _onEventAdded(WidgetRef ref) {
    ref.invalidate(controller.weekEventsProvider);
  }
}
