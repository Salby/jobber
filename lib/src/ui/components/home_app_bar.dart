import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/components/refresh_button.dart';

import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      forceElevated: true,
      centerTitle: true,
      title: Text(
        'Jobber',
        style: Theme.of(context).textTheme.title.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
      actions: <Widget>[
        RefreshButton(
          onPressed: () =>
              Provider.of<Positions>(context).getPositions(context),
        ),
      ],
      bottom: TabBar(
        indicatorColor: Theme.of(context).accentColor,
        tabs: <Widget>[
          Tab(text: 'Near me'),
          Tab(text: 'Saved'),
        ],
      ),
    );
  }
}
