import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/modules/upcoming_events/presentation/widgets/event_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';

class UpcomingEventsWidget extends ConsumerWidget {
  UpcomingEventsWidget({super.key});

  final int _eventListsPerSection = 3;
  final int _eventsPerList = 4;
  final EventController _controller = serviceLocator.get<EventController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final nextWeekEventsAsync = ref.watch(_controller.nextWeekEventsProvider);
    final thisMonthEventsAsync = ref.watch(_controller.thisMonthEventsProvider);
    final futureEventsAsync = ref.watch(_controller.futureEventsProvider);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(
          AppDimensions.containerBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                text: UpcomingEventsTranslations.title,
                style: theme.textTheme.titleMedium,
                color: theme.colorScheme.onPrimaryContainer,
              ),
              const Spacer(),
              AppIconButton(
                iconData: Icons.refresh_outlined,
                color: theme.colorScheme.onPrimaryContainer,
                onPressed: () {
                  _refreshUpcomingEvents(ref: ref);
                },
              ),
            ],
          ),
          VerticalGap.small(),
          Expanded(
            child: Row(
              children: [
                _buildSection(
                  theme: theme,
                  title: UpcomingEventsTranslations.nextWeek,
                  child: nextWeekEventsAsync.when(
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    error: (error, _) {
                      return Center(child: Text('Error: $error'));
                    },
                    data: (events) {
                      return _buildNextEventsLists(
                        theme: theme,
                        events: [
                          ...events,
                          ...events,
                          ...events,
                          ...events,
                          ...events,
                          ...events,
                        ],
                      );
                    },
                  ),
                ),
                HorizontalGap.medium(),
                _buildSection(
                  theme: theme,
                  title: UpcomingEventsTranslations.nextMonth,
                  child: thisMonthEventsAsync.when(
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    error: (error, _) {
                      return Center(child: Text('Error: $error'));
                    },
                    data: (events) {
                      return _buildNextEventsLists(
                        theme: theme,
                        events: events,
                      );
                    },
                  ),
                ),
                HorizontalGap.medium(),
                _buildSection(
                  theme: theme,
                  title: UpcomingEventsTranslations.future,
                  child: futureEventsAsync.when(
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    error: (error, _) {
                      return Center(child: Text('Error: $error'));
                    },
                    data: (events) {
                      return _buildNextEventsLists(
                        theme: theme,
                        events: events,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required ThemeData theme,
    required String title,
    required Widget child,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
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
              text: title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            VerticalGap.small(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  Widget _buildNextEventsLists({
    required ThemeData theme,
    required List<EventEntity> events,
  }) {
    if (events.isEmpty) {
      return const SizedBox();
    }

    return Row(
      children: List.generate(_eventListsPerSection, (listIndex) {
        final partialItems = events
            .skip(listIndex * _eventsPerList)
            .take(_eventsPerList)
            .toList();

        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...partialItems.map((event) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimensions.paddingSmall,
                    bottom: AppDimensions.spacingTiny,
                  ),
                  child: EventWidget(event: event),
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  void _refreshUpcomingEvents({required WidgetRef ref}) {
    ref.invalidate(_controller.nextWeekEventsProvider);
    ref.invalidate(_controller.thisMonthEventsProvider);
    ref.invalidate(_controller.futureEventsProvider);
  }
}
