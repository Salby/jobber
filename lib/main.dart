import 'package:flutter/material.dart';

import 'package:jobber/src/app.dart';
import 'package:jobber/src/core/models/settings.dart';

void main() async {
  await appSettings.getPrefsInstance();
  runApp(JobberApp());
}
