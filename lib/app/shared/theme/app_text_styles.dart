import 'package:flutter/material.dart';
import 'package:personal_planner/app/shared/constants/font_families.dart';

class AppTextStyles {
  static TextStyle displayLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.displayFontFamily,
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle displayMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.displayFontFamily,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle displaySmall({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.displayFontFamily,
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle titleLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.displayFontFamily,
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle titleMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.displayFontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle titleSmall({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.displayFontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bodyLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.defaultFontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.defaultFontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodySmall({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.defaultFontFamily,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyLargeBold({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.defaultFontFamily,
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bodyMediumBold({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.defaultFontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bodySmallBold({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.defaultFontFamily,
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
    );
  }
}
