import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/components/home_app_bar.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';

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
                Consumer<Positions>(
                  builder: (context, value, child) {
                    if (value.positions.isEmpty) {
                      value.getPositions();
                    }
                    if (value.isLoading) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final position = value.positions[index];
                          return ListTile(
                            title: Text(position['title']),
                            subtitle: Text(position['type']),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(height: 1.0),
                        itemCount: value.positions.length,
                      );
                    }
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
