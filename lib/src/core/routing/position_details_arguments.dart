import 'package:flutter/material.dart';

import 'package:morpheus/morpheus.dart';

/// A class that holds information needed to display details of a position on a
/// screen.
class PositionDetailsArguments extends MorpheusRouteArguments {
  PositionDetailsArguments({
    @required this.title,
    @required this.id,
    this.showSaveToggle = true,
    GlobalKey parentKey,
    Color transitionColor,
  })  : assert(title != null),
        assert(id != null),
        assert(showSaveToggle != null),
        super(
          parentKey: parentKey,
          transitionColor: transitionColor,
        );

  /// The title of this position.
  final String title;

  /// The unique id of this position.
  final String id;

  /// Show the button to edit the saved state of this position.
  final bool showSaveToggle;
}
