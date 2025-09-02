import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/design_system/text/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  final String labelText;
  final VoidCallback? onPressed;

  const AppPrimaryButton({super.key, required this.labelText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: onPressed,
      child: AppText(text: labelText),
    );
  }
}
