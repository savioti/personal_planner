import 'package:flutter/material.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/button/app_icon_button.dart';
import 'package:personal_planner/app/shared/design_system/gap/horizontal_gap.dart';
import 'package:personal_planner/app/shared/design_system/gap/vertical_gap.dart';
import 'package:personal_planner/app/shared/design_system/icon/app_icon.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';
import 'package:personal_planner/app/shared/theme/app_text_styles.dart';

class WeekViewEventWidget extends StatelessWidget {
  final EventEntity event;
  final Function(String eventId) onDelete;

  const WeekViewEventWidget({
    super.key,
    required this.event,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          AppDimensions.weekViewEventBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcon(
                iconData: Icons.event,
                color: theme.colorScheme.onPrimary,
              ),
              const HorizontalGap.tiny(),
              AppText(
                text: event.startTime.toEventTime,
                color: theme.colorScheme.onPrimary,
                style: AppTextStyles.bodySmallBold(),
              ),
              const Spacer(),
              _buildDeleteButton(),
            ],
          ),
          const VerticalGap.tiny(),
          AppText(
            text: event.title,
            color: theme.colorScheme.onPrimary,
            style: AppTextStyles.bodySmall(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return AppIconButton(
      iconData: Icons.delete,
      onPressed: () => onDelete(event.id),
    );
  }
}
