import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/domain/utils/event_utils.dart';
import 'package:personal_planner/app/modules/event/presentation/event_provider.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_add_event_dialog.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_day_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/e_weekday.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class WeekviewWidget extends ConsumerWidget {
  const WeekviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final weekDateRange = ref.watch(currentWeekDateRangeProvider);
    final weekEventsAsync = ref.watch(weekEventsProvider(weekDateRange));

    return Container(
      width: AppDimensions.weekViewWidthRatio * screenWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      child: Column(
        children: [
          _buildHeader(context: context),
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
                return _buildWeekDays(context: context, events: events);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required BuildContext context}) {
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
                return Dialog(child: WeekViewAddEventDialog());
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
              children: [
                Builder(
                  builder: (context) {
                    final mondayDate = daysOfTheWeek[0].toDateOnly;
                    final events = eventsByDay[mondayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.monday'),
                      weekday: EWeekday.monday,
                      events: events,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final tuesdayDate = daysOfTheWeek[1].toDateOnly;
                    final events = eventsByDay[tuesdayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.tuesday'),
                      weekday: EWeekday.tuesday,
                      events: events,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final wednesdayDate = daysOfTheWeek[2].toDateOnly;
                    final events = eventsByDay[wednesdayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.wednesday'),
                      weekday: EWeekday.wednesday,
                      events: events,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final thursdayDate = daysOfTheWeek[3].toDateOnly;
                    final events = eventsByDay[thursdayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.thursday'),
                      weekday: EWeekday.thursday,
                      events: events,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final fridayDate = daysOfTheWeek[4].toDateOnly;
                    final events = eventsByDay[fridayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.friday'),
                      weekday: EWeekday.friday,
                      events: events,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final saturdayDate = daysOfTheWeek[5].toDateOnly;
                    final events = eventsByDay[saturdayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.saturday'),
                      weekday: EWeekday.saturday,
                      events: events,
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final sundayDate = daysOfTheWeek[6].toDateOnly;
                    final events = eventsByDay[sundayDate] ?? [];

                    return WeekviewDayWidget(
                      title: tr('weekday.sunday'),
                      weekday: EWeekday.sunday,
                      events: events,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
