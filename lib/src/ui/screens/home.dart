import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/layout/positions_list.dart';
import 'package:jobber/src/ui/components/home_app_bar.dart';

import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Positions>(
      builder: (_) => Positions(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                Divider(height: 1.0),
                PositionsList(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
