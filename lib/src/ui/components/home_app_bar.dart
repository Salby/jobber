import 'package:flutter/material.dart';

import 'package:flutter_jobs/src/core/models/positions.dart';

import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      centerTitle: true,
      title: Text(
        'Jobber',
        style: Theme.of(context).textTheme.title.copyWith(
          color: Theme.of(context).accentColor,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () => Provider.of<Positions>(context).getPositions(),
        ),
      ],
    );
  }
}
