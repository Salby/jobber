import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';
import 'package:jobber/src/ui/screens/position_details.dart';

import 'package:provider/provider.dart';
import 'package:morpheus/morpheus.dart';

class PositionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Positions>(context);
    if (model.positions == null)
      model.getPositions(context);
    return LoadingTransition(
      contentChild: _content(context, model),
      loadingChild: _loading(context),
      loading: model.isLoading,
    );
  }

  Widget _content(BuildContext context, Positions model) {
    if (model.positions == null || model.positions.isEmpty) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2,
        alignment: Alignment.center,
        child: Flexible(
          child: Text(
            'Sorry, there are no open positions in your area',
            style: Theme
                .of(context)
                .textTheme
                .display1,
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
          final parentKey = GlobalKey();
          return ListTile(
            key: parentKey,
            title: Text(position['title']),
            subtitle: Text(position['location']),
            onTap: () =>
                Navigator.of(context).push(MorpheusPageRoute(
                  builder: (_) =>
                      PositionDetails(
                        title: position['title'],
                        id: position['id'],
                      ),
                  parentKey: parentKey,
                  scrimColor: Theme
                      .of(context)
                      .cardColor,
                )),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1.0),
        itemCount: model.positions.length,
      );
    }
  }

  Widget _loading(BuildContext context) =>
      Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
}
