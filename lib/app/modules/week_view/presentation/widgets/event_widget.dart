import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class EventWidget extends ConsumerWidget {
  final EventEntity event;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;

  EventWidget({super.key, required this.event, this.onTap, this.onComplete});

  final hoveringProvider = StateProvider.autoDispose<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isHovering = ref.watch(hoveringProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => ref.read(hoveringProvider.notifier).state = true,
      onExit: (_) => ref.read(hoveringProvider.notifier).state = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHovering ? theme.highlightColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: AppDimensions.weekViewTaskItemHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingSmall,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: event.startTime.toTime,
                            style: theme.textTheme.bodySmall,
                          ),
                          Divider(
                            thickness:
                                AppDimensions.weekViewItemUnderlineThickness,
                            height:
                                AppDimensions.weekViewItemUnderlineThickness,
                            color: isHovering
                                ? theme.primaryColor
                                : theme.dividerColor,
                          ),
                        ],
                      ),
                    ),

                    Expanded(child: AppText(text: event.title)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingSmall,
                  ),
                  child: Divider(
                    thickness: AppDimensions.weekViewItemUnderlineThickness,
                    height: AppDimensions.weekViewItemUnderlineThickness,
                    color: isHovering ? theme.primaryColor : theme.dividerColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
