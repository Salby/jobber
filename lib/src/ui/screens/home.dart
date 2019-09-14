import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/layout/positions_list.dart';
import 'package:jobber/src/ui/layout/saved_list.dart';
import 'package:jobber/src/ui/components/home_app_bar.dart';

import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [HomeAppBar()],
          body: TabBarView(
            children: <Widget>[
              RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<Positions>(context).getPositions(context);
                  return true;
                },
                child: PositionsList(),
              ),
              SavedList(),
            ],
          ),
        ),
      ),
    );
  }
}
