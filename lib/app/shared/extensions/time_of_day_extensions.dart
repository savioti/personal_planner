import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get formatTo24Hour {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }
}
