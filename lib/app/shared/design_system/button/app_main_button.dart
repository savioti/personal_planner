import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/size_tokens.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';

enum EButtonType { primary, secondary, tertiary, text }

class AppMainButton extends StatelessWidget {
  final String labelText;
  final EButtonType buttonType;
  final VoidCallback? onPressed;

  const AppMainButton({
    super.key,
    required this.labelText,
    this.buttonType = EButtonType.primary,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _getStyle(context: context),
      onPressed: onPressed,
      child: AppText(text: labelText),
    );
  }

  ButtonStyle _getStyle({required BuildContext context}) {
    switch (buttonType) {
      case EButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.mainButtonBorderRadius,
            ),
          ),
        );
      case EButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: AppDimensions.mainButtonBorderWidth,
            ),
            borderRadius: BorderRadius.circular(
              AppDimensions.mainButtonBorderRadius,
            ),
          ),
        );
      case EButtonType.tertiary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.mainButtonBorderRadius,
            ),
          ),
        );
      case EButtonType.text:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.mainButtonBorderRadius,
            ),
          ),
        );
    }
  }
}
