import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_text_field.dart';

class AppDateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  const AppDateTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return AppTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      readOnly: true,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: now.subtract(const Duration(days: 7)),
          lastDate: DateTime(now.year + 2),
        );

        if (pickedDate != null) {
          controller.text = pickedDate.toIso8601String().split('T').first;
        }
      },
    );
  }
}
