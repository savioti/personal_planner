import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_event_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/e_weekday.dart';

class WeekviewDayWidget extends StatelessWidget {
  final String title;
  final EWeekday weekday;
  final List<EventEntity> events;
  final bool useVariantColor;

  const WeekviewDayWidget({
    super.key,
    required this.weekday,
    required this.title,
    required this.events,
    this.useVariantColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final weekViewWidth = AppDimensions.weekViewWidthRatio * screenWidth;
    final weekdayCardWidth =
        (weekViewWidth - AppDimensions.cardPadding * 2) / 7;

    return Container(
      width: weekdayCardWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: useVariantColor
            ? theme.colorScheme.surfaceContainerLow
            : theme.colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          AppText(text: title),
          const VerticalGap.medium(),
          Expanded(
            child: ListView.separated(
              itemCount: events.length,
              separatorBuilder: (context, index) => const VerticalGap.small(),
              itemBuilder: (context, index) {
                final event = events[index];
                return WeekViewEventWidget(event: event);
              },
            ),
          ),
        ],
      ),
    );
  }
}
