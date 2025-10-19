import 'package:flutter/material.dart';

class DisabledArea extends StatelessWidget {
  const DisabledArea({required this.child, required this.disabled, super.key});

  final Widget child;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: AbsorbPointer(absorbing: disabled, child: child),
    );
  }
}
