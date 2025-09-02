import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_add_event_dialog.dart';
import 'package:personal_planner/app/modules/event/presentation/widgets/week_view_day_widget.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/enums/e_weekday.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class WeekviewWidget extends ConsumerWidget {
  const WeekviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tr = serviceLocator.get<TranslationsController>();

    return Container(
      width: AppDimensions.weekViewWidthRatio * screenWidth,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          const VerticalGap.small(),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                AppDimensions.cardBorderRadius,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WeekviewDayWidget(
                    title: tr('weekday.monday'),
                    weekday: EWeekday.monday,
                    events: [],
                  ),
                  WeekviewDayWidget(
                    title: tr('weekday.tuesday'),
                    weekday: EWeekday.tuesday,
                    useVariantColor: true,
                    events: [],
                  ),
                  WeekviewDayWidget(
                    title: tr('weekday.wednesday'),
                    weekday: EWeekday.wednesday,
                    events: [],
                  ),
                  WeekviewDayWidget(
                    title: tr('weekday.thursday'),
                    weekday: EWeekday.thursday,
                    useVariantColor: true,
                    events: [],
                  ),
                  WeekviewDayWidget(
                    title: tr('weekday.friday'),
                    weekday: EWeekday.friday,
                    events: [],
                  ),
                  WeekviewDayWidget(
                    title: tr('weekday.saturday'),
                    weekday: EWeekday.saturday,
                    useVariantColor: true,
                    events: [],
                  ),
                  WeekviewDayWidget(
                    title: tr('weekday.sunday'),
                    weekday: EWeekday.sunday,
                    events: [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
