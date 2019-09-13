import 'package:flutter/material.dart';

import 'package:jobber/src/ui/layout/positions_list.dart';
import 'package:jobber/src/ui/layout/saved_list.dart';
import 'package:jobber/src/ui/components/home_app_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(),
            SliverFillRemaining(
              child: TabBarView(children: <Widget>[
                PositionsList(),
                SavedList(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
