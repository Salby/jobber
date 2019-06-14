import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';

import 'package:provider/provider.dart';

class PositionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Positions>(context);
    return LoadingTransition(
      child: Builder(builder: (context) {
        if (model.positions == null) {
          model.getPositions(context);
        }
        if (model.isLoading) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        } else {
          if (model.positions.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              alignment: Alignment.center,
              child: Flexible(
                child: Text(
                  'Sorry, there are no open positions in your area',
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final position = model.positions[index];
                return ListTile(
                  title: Text(position['title']),
                  subtitle: Text(position['location']),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 1.0),
              itemCount: model.positions.length,
            );
          }
        }
      }),
    );
  }
}
