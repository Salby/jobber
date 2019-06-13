import 'package:flutter/material.dart';

import 'package:jobber/src/ui/theme/colors.dart';

ThemeData buildTheme() {
  final base = ThemeData.dark();

  return base.copyWith(
    colorScheme: colorScheme,

    primaryColor: colorScheme.primary,
    accentColor: colorScheme.secondary,

    scaffoldBackgroundColor: colorScheme.background,

    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

_buildTextTheme(TextTheme base) {
  return base.copyWith(
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