import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/settings.dart';

import 'package:provider/provider.dart';

/// A screen that displays the app's settings.
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Settings settings = Provider.of<Settings>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Positions',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          SwitchListTile.adaptive(
            activeColor: Theme.of(context).colorScheme.secondary,
            title: Text('Use location'),
            subtitle: Text('Positions will be filtered by the your location.'),
            value: settings.useLocation,
            onChanged: (setting) => settings.updateSetting(
              SettingCodes.useLocation,
              setting,
            ),
          ),
        ],
      ),
    );
  }
}
