// a text field that allows users to input a time calling the flutter date picker dialog
import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/design_system/text_field/app_text_field.dart';
import 'package:personal_planner/app/shared/extensions/time_of_day_extensions.dart';

class AppTimeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;

  const AppTimeTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      readOnly: true,
      onTap: () async {
        final now = DateTime.now();
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(now),
          initialEntryMode: TimePickerEntryMode.dial,
        );

        if (pickedTime != null && context.mounted) {
          controller.text = pickedTime.formatTo24Hour;
        }
      },
    );
  }
}
