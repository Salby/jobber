import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jobber/src/ui/theme/theme.dart';
import 'package:jobber/src/ui/screens/home.dart';

class JobberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = buildTheme();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jobber',
      theme: theme,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: theme.colorScheme.background,
        ),
        child: Home(),
      ),
    );
  }
}
