import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/position.dart';
import 'package:jobber/src/ui/screens/position_details.dart';

import 'package:morpheus/morpheus.dart';

/// Builds a [ListTile] that pushes a position screen when tapped. The tile
/// allows the user to remove the position from the saved list without going
/// directly to the position screen.
class SavedPosition extends StatelessWidget {
  const SavedPosition({
    Key key,
    @required this.position,
    this.animation,
    @required this.parentKey,
  }) : super(key: key);

  /// The [position] that contains the data that will populate the tile as well
  /// as the [PositionDetails] screen that is pushed on tap.
  final Position position;

  /// The animation used to transition the tile in or out of the 'saved' list.
  final Animation<double> animation;

  /// A [GlobalKey] used when pushing the [PositionDetails] screen via a
  /// [MorpheusPageRoute].
  final GlobalKey parentKey;

  @override
  Widget build(BuildContext context) {
    final Widget tile = ListTile(
      key: parentKey,
      title: Text(position.title),
      subtitle: Text(position.location),
      onTap: () => _showPositionDetails(context),

      // TODO: Add a trailing button that lets the user remove the position from the positions list.
      trailing: IconTheme(
        data: Theme.of(context).primaryIconTheme,
        child: IconButton(
          icon: Icon(Icons.remove),
          tooltip: 'Remove from saved',
          onPressed: () => Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('This button currently does nothing.'),
          )),
        ),
      ),
    );

    // Return only the tile if no animation has been provided to listen to.
    if (animation == null) {
      return tile;
    } else {
      // Build animation used when animating the tile in or out of the list.
      final Animation<double> transitionAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      ));

      return SizeTransition(
        sizeFactor: transitionAnimation,
        child: FadeTransition(
          opacity: transitionAnimation,
          child: tile,
        ),
      );
    }
  }

  /// Pushes a [PositionDetails] screen showing a detailed overview of
  /// [position].
  Future<void> _showPositionDetails(BuildContext context) async {
    await Navigator.of(context).push(MorpheusPageRoute(
      builder: (context) => PositionDetails(
        title: position.title,
        id: position.id,

        // Don't have a button for toggling the saved state since that will
        // be handled by the tiled.
        showSavedToggle: false,
      ),
      parentKey: parentKey,
      transitionDuration: const Duration(milliseconds: 400),
    ));
  }
}
