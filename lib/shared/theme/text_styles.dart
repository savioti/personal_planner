import 'package:flutter/material.dart';
import 'package:personal_planner/shared/theme/color_tokens.dart';

class TextStyles {
  static TextStyle extraBold({double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? 20.0,
      color: color ?? ColorTokens.white2,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle bold({double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? 18.0,
      color: color ?? ColorTokens.white2,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle semiBold({double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? 16.0,
      color: color ?? ColorTokens.white2,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle regular({double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? 14.0,
      color: color ?? ColorTokens.white2,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle light({double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? 12.0,
      color: color ?? ColorTokens.white2,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle extraLight({double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? 10.0,
      color: color ?? ColorTokens.white2,
      fontWeight: FontWeight.w200,
    );
  }
}
