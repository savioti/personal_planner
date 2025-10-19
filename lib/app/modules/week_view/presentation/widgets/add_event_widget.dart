import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';

class AddEventWidget extends ConsumerWidget {
  final VoidCallback? onTap;

  AddEventWidget({super.key, this.onTap});

  final hoveringProvider = StateProvider.autoDispose<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isHovering = ref.watch(hoveringProvider);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => ref.read(hoveringProvider.notifier).state = true,
        onExit: (_) => ref.read(hoveringProvider.notifier).state = false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isHovering ? theme.highlightColor : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
          ),
          child: SizedBox(
            height: AppDimensions.weekViewTaskItemHeight,
            child: Builder(
              builder: (context) {
                if (isHovering) {
                  return Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      color: theme.primaryColor,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.spacingSmall,
                    left: AppDimensions.spacingSmall,
                    right: AppDimensions.spacingSmall,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Divider(
                      thickness: AppDimensions.weekViewItemUnderlineThickness,
                      height: AppDimensions.weekViewItemUnderlineThickness,
                      color: theme.dividerColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
