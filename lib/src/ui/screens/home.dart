import 'package:flutter/material.dart';

import 'package:flutter_jobs/src/core/models/positions.dart';
import 'package:flutter_jobs/src/ui/components/home_app_bar.dart';

import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Positions>(
      builder: (_) => Positions(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(),
            Consumer<Positions>(
              builder: (context, value, child) {
                if (value.positions.isEmpty) {
                  value.getPositions();
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final position = value.positions[index];
                      return Column(
                        children: <Widget>[
                          Divider(height: 1.0),
                          ListTile(
                            title: Text(position['title']),
                            subtitle: Text(position['type']),
                            onTap: () => null,
                          ),
                        ],
                      );
                    },
                    childCount: value.positions.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
