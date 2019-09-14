import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/core/models/position.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';
import 'package:jobber/src/ui/components/saved_position.dart';

import 'package:provider/provider.dart';

class SavedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Positions>(
      builder: (context, model, child) => LoadingTransition(
        child: model.isLoading ? _loading(context) : _content(context, model),
      ),
    );
  }

  Widget _content(BuildContext context, Positions model) {
    if (model.positions == null || model.positions.isEmpty) {
      return Container(
        key: Key('Empty'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Couldn't find any saved positions",
          style: Theme.of(context).textTheme.subhead.copyWith(
            color: Colors.white54,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return AnimatedList(
        key: model.savedListKey,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        initialItemCount: model.saved.length,
        itemBuilder: (context, index, animation) {
          final position = Position.fromJson(model.saved[index]);
          return Column(
            children: <Widget>[
              SavedPosition(
                position: position,
                animation: animation,
                parentKey: model.keys['saved'][index],
              ),
              Divider(height: 1.0),
            ],
          );
        },
      );
    }
  }

  Widget _loading(BuildContext context) => Container(
        key: Key('Loading'),
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
}
