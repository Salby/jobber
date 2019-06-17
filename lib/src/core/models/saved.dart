import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Saved with ChangeNotifier {
  Saved(this.positionId) {
    _getInstance();
    getSaved();
  }

  final String positionId;
  bool saved = false;
  SharedPreferences _prefsInstance;

  void getSaved() async {
    if (_prefsInstance == null) await _getInstance();
    saved = await _saved();
    notifyListeners();
  }

  void toggleSaved() async {
    if (_prefsInstance == null) await _getInstance();
    final savedPositions = _prefsInstance.getStringList('savedPositions') ?? [];
    if (savedPositions.contains(positionId)) {
      savedPositions.remove(positionId);
    } else {
      savedPositions.add(positionId);
      _prefsInstance.setStringList('savedPositions', savedPositions);
    }
    saved = !saved;
    notifyListeners();
  }

  Future<bool> _saved() async {
    if (_prefsInstance == null) await _getInstance();
    final savedPositions = _prefsInstance.getStringList('savedPositions') ?? [];
    return savedPositions.contains(positionId);
  }

  Future<void> _getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    _prefsInstance = prefs;
  }
}