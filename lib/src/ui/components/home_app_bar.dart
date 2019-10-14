import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:jobber/src/core/services/location_service.dart';
import 'package:jobber/src/core/models/settings.dart';
import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/ui/screens/settings_screen.dart';
import 'package:jobber/src/ui/components/refresh_button.dart';

import 'package:provider/provider.dart';
import 'package:morpheus/morpheus.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      forceElevated: true,
      title: Text(
        'Jobber',
        style: Theme.of(context).textTheme.title.copyWith(
              color: Theme.of(context).accentColor,
            ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(OMIcons.settings),
          tooltip: 'Settings',
          onPressed: () => _showSettingsScreen(context),
        ),
        RefreshButton(
          onPressed: () => Provider.of<Positions>(context).getPositions(
            location: Provider.of<Settings>(context).useLocation
                ? Provider.of<UserLocation>(context)
                : null,
          ),
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

  void _showSettingsScreen(BuildContext context) {
    Navigator.of(context).push(Platform.isIOS || Platform.isMacOS
        ? CupertinoPageRoute(builder: (_) => SettingsScreen())
        : MorpheusPageRoute(builder: (_) => SettingsScreen()));
  }
}
