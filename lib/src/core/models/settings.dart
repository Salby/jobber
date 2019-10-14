import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// Holds the codes used to access a value from [SharedPreferences].
class SettingCodes {
  static const String useLocation = 'settings.useLocation';
}

/// Holds the app's settings.
class Settings with ChangeNotifier {
  Settings({SharedPreferences instance}) : prefsInstance = instance;

  SharedPreferences prefsInstance;

  bool get useLocation =>
      prefsInstance.getBool(SettingCodes.useLocation) ?? true;

  /// Update the value of a setting.
  ///
  /// Use a constant from [SettingCodes] for the [settingCode] parameter.
  ///
  /// Throws [AssertionError] if [newValue] isn't of a valid type. The valid
  /// types to use is:
  /// * [bool]
  /// * [double]
  /// * [int]
  /// * [String]
  /// * [List<String>]
  Future<void> updateSetting(String settingCode, dynamic newValue) async {
    // Throw exception if the setting code is null.
    if (settingCode == null) {
      throw AssertionError('The `settingCode` parameter can\'t be null.');
    }

    // Update the value of [settingCode]. Throw an exception if [newValue]
    // isn't a valid type.
    switch (newValue.runtimeType) {
      case bool:
        await prefsInstance.setBool(settingCode, newValue);
        break;
      case double:
        await prefsInstance.setDouble(settingCode, newValue);
        break;
      case int:
        await prefsInstance.setInt(settingCode, newValue);
        break;
      case String:
        await prefsInstance.setString(settingCode, newValue);
        break;
      case List:
        await prefsInstance.setStringList(settingCode, newValue);
        break;
      default:
        throw AssertionError(
          'Couldn\'t update setting because `newValue` isn\'t a valid type.',
        );
        break;
    }
    notifyListeners();
  }

  Future<void> getPrefsInstance() async {
    final instance = await SharedPreferences.getInstance();
    prefsInstance = instance;
  }
}

final Settings appSettings = Settings();
