import "package:flutter/material.dart";

class CyberwaveTheme {
  final TextTheme textTheme;

  const CyberwaveTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff705289),
      surfaceTint: Color(0xff705289),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff1daff),
      onPrimaryContainer: Color(0xff573a70),
      secondary: Color(0xff814c77),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffd7f2),
      onSecondaryContainer: Color(0xff67355e),
      tertiary: Color(0xff00696c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9cf1f3),
      onTertiaryContainer: Color(0xff004f51),
      error: Color(0xff8d4a5c),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffd9e0),
      onErrorContainer: Color(0xff703345),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff1a1b21),
      onSurfaceVariant: Color(0xff514347),
      outline: Color(0xff837377),
      outlineVariant: Color(0xffd5c2c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffdcb9f8),
      primaryFixed: Color(0xfff1daff),
      onPrimaryFixed: Color(0xff290c41),
      primaryFixedDim: Color(0xffdcb9f8),
      onPrimaryFixedVariant: Color(0xff573a70),
      secondaryFixed: Color(0xffffd7f2),
      onSecondaryFixed: Color(0xff350830),
      secondaryFixedDim: Color(0xfff3b2e3),
      onSecondaryFixedVariant: Color(0xff67355e),
      tertiaryFixed: Color(0xff9cf1f3),
      onTertiaryFixed: Color(0xff002021),
      tertiaryFixedDim: Color(0xff80d4d7),
      onTertiaryFixedVariant: Color(0xff004f51),
      surfaceDim: Color(0xffdad9e0),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffeeedf4),
      surfaceContainerHigh: Color(0xffe8e7ef),
      surfaceContainerHighest: Color(0xffe3e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8f0076),
      surfaceTint: Color(0xff8f0076),
      onPrimary: Color(0xffffda45),
      primaryContainer: Color(0xff682b9c),
      onPrimaryContainer: Color(0xffffda45),
      secondary: Color(0xffd74ac7),
      onSecondary: Color(0xff93fff8),
      secondaryContainer: Color(0xff67355e),
      onSecondaryContainer: Color(0xff93fff8),
      tertiary: Color(0xff80d4d7),
      onTertiary: Color(0xff003738),
      tertiaryContainer: Color(0xff004f51),
      onTertiaryContainer: Color(0xff9cf1f3),
      error: Color(0xfff50078),
      onError: Color(0xffffd5cc),
      errorContainer: Color(0xffab1f65),
      onErrorContainer: Color(0xffffd5cc),
      surface: Color(0xff4d004c),
      onSurface: Color(0xffe3e2e9),
      onSurfaceVariant: Color(0xffd5c2c6),
      outline: Color(0xff4d004c),
      outlineVariant: Color(0xff3d0039),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e9),
      inversePrimary: Color(0xff705289),
      primaryFixed: Color(0xfff1daff),
      onPrimaryFixed: Color(0xff290c41),
      primaryFixedDim: Color(0xffdcb9f8),
      onPrimaryFixedVariant: Color(0xff573a70),
      secondaryFixed: Color(0xffffd7f2),
      onSecondaryFixed: Color(0xff350830),
      secondaryFixedDim: Color(0xfff3b2e3),
      onSecondaryFixedVariant: Color(0xff67355e),
      tertiaryFixed: Color(0xff9cf1f3),
      onTertiaryFixed: Color(0xff002021),
      tertiaryFixedDim: Color(0xff80d4d7),
      onTertiaryFixedVariant: Color(0xff004f51),
      surfaceDim: Color(0xff3d0039),
      surfaceBright: Color(0xff6b0058),
      surfaceContainerLowest: Color(0xff2a001f),
      surfaceContainerLow: Color(0xff420042),
      surfaceContainer: Color(0xff5a0050),
      surfaceContainerHigh: Color(0xff6f0060),
      surfaceContainerHighest: Color(0xff850070),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );
}
