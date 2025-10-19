import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final void Function()? onTap;

  const AppTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.onPrimary),
        ),
        labelText: labelText,
        hintText: hintText,
      ),
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}
