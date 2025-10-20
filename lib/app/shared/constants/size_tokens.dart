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
  static const double spacingMedium = BaseTokens.space3;
  static const double spacingLarge = BaseTokens.space4;
  static const double spacingXLarge = BaseTokens.space5;
  static const double spacingXXLarge = BaseTokens.space6;
  static const double spacingXXXLarge = BaseTokens.space8;

  static const double paddingTiny = spacingTiny;
  static const double paddingSmall = spacingSmall;
  static const double paddingMedium = spacingMedium;
  static const double paddingLarge = spacingLarge;
  static const double paddingXLarge = spacingXLarge;
  static const double paddingXXLarge = spacingXXLarge;

  static const double radiusSmall = BaseTokens.space1;
  static const double radiusMedium = BaseTokens.space2;
  static const double radiusLarge = BaseTokens.space4;

  static const double iconSizeSmall = 8.0;
  static const double iconSizeMedium = 16.0;
  static const double iconSizeLarge = 24.0;

  static const double cardPadding = paddingMedium;
  static const double cardBorderRadius = radiusSmall;

  static const double containerBorderRadius = radiusMedium;

  static const double buttonPadding = paddingMedium;
  static const double inputPadding = paddingMedium;

  static const double weekViewDayCardLargeMinWidth = 128.0;
  static const double weekViewWidthRatio = 0.675;
  static const double weekViewEventBorderRadius = 16.0;

  static const double weekTasksWidthRatio = 0.15;

  static const double dialogBorderWidth = 2.0;
  static const double dialogBorderRadius = 16.0;
  static const double dialogMaxWidth = 400.0;

  static const double mainButtonBorderRadius = radiusLarge;
  static const double mainButtonBorderWidth = 1.0;

  static const double iconButtonSize = 24.0;
  static const double iconButtonIconSize = 16.0;
  static const double iconButtonBorderRadius = radiusSmall;

  static const double tileButtonBorderRadius = radiusLarge;

  static const double checkboxBorderRadius = 6.0;
  static const double checkboxSize = 24.0;

  static const double weekViewTaskItemHeight = 32.0;
  static const double weekViewVerticalDividerWidth = 16.0;
  static const double weekViewHorizontalDividerLength = 32.0;
  static const double weekViewItemUnderlineThickness = 2.0;
}
