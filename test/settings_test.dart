import 'package:jobber/src/core/models/settings.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences prefsInstance;

  setUp(() {
    prefsInstance = MockSharedPreferences();
  });

  test('Settings are fetched from store', () {
    when(prefsInstance.getBool(SettingCodes.useLocation)).thenReturn(false);

    final Settings settings = Settings(instance: prefsInstance);

    expect(settings.useLocation, false);
  });

  test('Setting is updated', () async {
    bool setting;
    when(prefsInstance.getBool(SettingCodes.useLocation)).thenReturn(false);
    when(prefsInstance.setBool(SettingCodes.useLocation, true)).thenAnswer((_) {
      setting = true;
      return Future.value(null);
    });

    final Settings settings = Settings(instance: prefsInstance);

    expect(settings.useLocation, false);
    await settings.updateSetting(SettingCodes.useLocation, true);
    expect(setting, true);
  });

  test('Throws exception when updating null setting', () async {
    final Settings settings = Settings(instance: prefsInstance);

    expect(
      () => settings.updateSetting(null, null),
      throwsAssertionError,
    );
  });

  test('Setting cannot be updated with invalid type', () async {
    final Settings settings = Settings(instance: prefsInstance);

    expect(
      () => settings.updateSetting(SettingCodes.useLocation, {'x': 'y'}),
      throwsAssertionError,
    );
  });
}
