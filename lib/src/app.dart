import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobber/src/core/routing/routes.dart';
import 'package:jobber/src/core/models/settings.dart';
import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/core/services/location_service.dart';
import 'package:jobber/src/ui/theme/theme.dart';

import 'package:provider/provider.dart';

class JobberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = buildTheme();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: LocationService().locationStream,
        ),
        ChangeNotifierProvider<Settings>.value(
          value: appSettings,
        ),
      ],
      child: Consumer<UserLocation>(
        builder: (context, model, _) => ChangeNotifierProvider(
          builder: (context) => Positions()
            ..getPositions(location: appSettings.useLocation ? model : null),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jobber',
            theme: theme,
            onGenerateRoute: (settings) => generateRoutes(settings),
          ),
        ),
      ),
    );
  }
}
