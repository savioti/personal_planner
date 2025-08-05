class BaseTokens {
  static const double unit = 4.0;

  static const double space1 = unit;
  static const double space2 = unit * 2;
  static const double space3 = unit * 3;
  static const double space4 = unit * 4;
  static const double space5 = unit * 5;
  static const double space6 = unit * 6;
  static const double space8 = unit * 8;
  static const double space10 = unit * 10;
  static const double space12 = unit * 12;
}

class AppDimensions {
  static const double spacingTiny = BaseTokens.space1;
  static const double spacingSmall = BaseTokens.space2;
  static const double spacingMedium = BaseTokens.space4;
  static const double spacingLarge = BaseTokens.space6;
  static const double spacingXLarge = BaseTokens.space8;

  static const double paddingTiny = spacingTiny;
  static const double paddingSmall = spacingSmall;
  static const double paddingMedium = spacingMedium;
  static const double paddingLarge = spacingLarge;

  static const double radiusSmall = BaseTokens.space1;
  static const double radiusMedium = BaseTokens.space2;
  static const double radiusLarge = BaseTokens.space3;

  static const double cardPadding = paddingMedium;
  static const double cardBorderRadius = radiusSmall;
  static const double buttonPadding = paddingMedium;
  static const double inputPadding = paddingMedium;

  static const double weekdayCardLargeMinWidth = 128.0;
  static const double weekViewWidthRatio = 0.7;
  static const double weekTasksWidthRatio = 0.25;
}
