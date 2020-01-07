import 'package:flutter/material.dart';

import 'package:jobber/src/app.dart';
import 'package:jobber/src/core/models/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appSettings.getPrefsInstance();
  runApp(JobberApp());
}
