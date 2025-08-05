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

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff45295e),
      surfaceTint: Color(0xff705289),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff7f6099),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff54244d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff925b86),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003d3f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff16797c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5c2235),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff9e586b),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff101116),
      onSurfaceVariant: Color(0xff3f3337),
      outline: Color(0xff5d4f53),
      outlineVariant: Color(0xff79696d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffdcb9f8),
      primaryFixed: Color(0xff7f6099),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff66487f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff925b86),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff77436d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff16797c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005f61),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6c6cd),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3fa),
      surfaceContainer: Color(0xffe8e7ef),
      surfaceContainerHigh: Color(0xffdddce3),
      surfaceContainerHighest: Color(0xffd2d1d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b1f53),
      surfaceTint: Color(0xff705289),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff593d72),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff481a42),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6a3761),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003233),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005254),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff50182b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff733547),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffaf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff35292d),
      outlineVariant: Color(0xff534649),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3036),
      inversePrimary: Color(0xffdcb9f8),
      primaryFixed: Color(0xff593d72),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff42265a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6a3761),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff502149),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005254),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00393b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb8b8bf),
      surfaceBright: Color(0xfffaf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f0f7),
      surfaceContainer: Color(0xffe3e2e9),
      surfaceContainerHigh: Color(0xffd4d4db),
      surfaceContainerHighest: Color(0xffc6c6cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdcb9f8),
      surfaceTint: Color(0xffdcb9f8),
      onPrimary: Color(0xff3f2358),
      primaryContainer: Color(0xff573a70),
      onPrimaryContainer: Color(0xfff1daff),
      secondary: Color(0xfff3b2e3),
      onSecondary: Color(0xff4d1f46),
      secondaryContainer: Color(0xff67355e),
      onSecondaryContainer: Color(0xffffd7f2),
      tertiary: Color(0xff80d4d7),
      onTertiary: Color(0xff003738),
      tertiaryContainer: Color(0xff004f51),
      onTertiaryContainer: Color(0xff9cf1f3),
      error: Color(0xffffb1c4),
      onError: Color(0xff551d2f),
      errorContainer: Color(0xff703345),
      onErrorContainer: Color(0xffffd9e0),
      surface: Color(0xff121318),
      onSurface: Color(0xffe3e2e9),
      onSurfaceVariant: Color(0xffd5c2c6),
      outline: Color(0xff9e8c91),
      outlineVariant: Color(0xff514347),
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
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff38393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1a1b21),
      surfaceContainer: Color(0xff1e1f25),
      surfaceContainerHigh: Color(0xff292a2f),
      surfaceContainerHighest: Color(0xff33343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedd3ff),
      surfaceTint: Color(0xffdcb9f8),
      onPrimary: Color(0xff34184c),
      primaryContainer: Color(0xffa484bf),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffcef1),
      onSecondary: Color(0xff41133b),
      secondaryContainer: Color(0xffb97eac),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff96eaed),
      onTertiary: Color(0xff002b2c),
      tertiaryContainer: Color(0xff479da0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd1da),
      onError: Color(0xff471224),
      errorContainer: Color(0xffc77a8e),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffecd7dc),
      outline: Color(0xffc0adb2),
      outlineVariant: Color(0xff9d8c90),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e9),
      inversePrimary: Color(0xff583b71),
      primaryFixed: Color(0xfff1daff),
      onPrimaryFixed: Color(0xff1e0136),
      primaryFixedDim: Color(0xffdcb9f8),
      onPrimaryFixedVariant: Color(0xff45295e),
      secondaryFixed: Color(0xffffd7f2),
      onSecondaryFixed: Color(0xff270024),
      secondaryFixedDim: Color(0xfff3b2e3),
      onSecondaryFixedVariant: Color(0xff54244d),
      tertiaryFixed: Color(0xff9cf1f3),
      onTertiaryFixed: Color(0xff001415),
      tertiaryFixedDim: Color(0xff80d4d7),
      onTertiaryFixedVariant: Color(0xff003d3f),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff43444a),
      surfaceContainerLowest: Color(0xff06070c),
      surfaceContainerLow: Color(0xff1c1d23),
      surfaceContainer: Color(0xff26282d),
      surfaceContainerHigh: Color(0xff313238),
      surfaceContainerHighest: Color(0xff3c3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffaebff),
      surfaceTint: Color(0xffdcb9f8),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffd8b5f4),
      onPrimaryContainer: Color(0xff16002b),
      secondary: Color(0xffffeaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffefafdf),
      onSecondaryContainer: Color(0xff1d001b),
      tertiary: Color(0xffb4fdff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff7cd0d3),
      onTertiaryContainer: Color(0xff000e0e),
      error: Color(0xffffebee),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffabc0),
      onErrorContainer: Color(0xff21000a),
      surface: Color(0xff121318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffebef),
      outlineVariant: Color(0xffd1bec2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e9),
      inversePrimary: Color(0xff583b71),
      primaryFixed: Color(0xfff1daff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffdcb9f8),
      onPrimaryFixedVariant: Color(0xff1e0136),
      secondaryFixed: Color(0xffffd7f2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xfff3b2e3),
      onSecondaryFixedVariant: Color(0xff270024),
      tertiaryFixed: Color(0xff9cf1f3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff80d4d7),
      onTertiaryFixedVariant: Color(0xff001415),
      surfaceDim: Color(0xff121318),
      surfaceBright: Color(0xff4f5056),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1e1f25),
      surfaceContainer: Color(0xff2f3036),
      surfaceContainerHigh: Color(0xff3a3b41),
      surfaceContainerHighest: Color(0xff45464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
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

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
