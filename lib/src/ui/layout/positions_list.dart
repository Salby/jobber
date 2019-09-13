import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';
import 'package:jobber/src/ui/screens/position_details.dart';

import 'package:provider/provider.dart';
import 'package:morpheus/morpheus.dart';

class PositionsList extends StatelessWidget {
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
          'Sorry, there are no open positions in your area. Please try again later',
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white54,
              ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.separated(
        key: Key('Content'),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final position = model.positions[index];
          final parentKey = model.keys['positions'][index];
          final bool saved =
              model.saved.where((_) => _['id'] == position['id']).isNotEmpty;
          return ListTile(
            key: parentKey,
            title: Text(position['title']),
            subtitle: Text(position['location']),
            trailing: saved
                ? Icon(
                    Icons.bookmark,
                    color: Colors.white54,
                  )
                : null,
            onTap: () => Navigator.of(context).push(MorpheusPageRoute(
              builder: (_) => PositionDetails(
                title: position['title'],
                id: position['id'],
              ),
              parentKey: parentKey,
            )),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1.0),
        itemCount: model.positions.length,
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
