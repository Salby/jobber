import 'package:flutter/material.dart';

import 'package:jobber/src/ui/theme/colors.dart';

ThemeData buildTheme() {
  final base = ThemeData.dark();

  return base.copyWith(
    colorScheme: colorScheme,

    primaryColor: colorScheme.primary,
    primaryColorDark: colorScheme.primaryVariant,
    accentColor: colorScheme.secondary,

    scaffoldBackgroundColor: colorScheme.background,
    cardColor: colorScheme.surface,

    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

_buildTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontFamily: 'Noto Sans HK',
      fontWeight: FontWeight.w700,
    ),
    title: base.title.copyWith(
      fontFamily: 'Noto Sans HK',
      fontWeight: FontWeight.w900,
    ),
    button: base.button.copyWith(
      fontFamily: 'Noto Sans HK',
      fontWeight: FontWeight.w700,
    ),
  );
}