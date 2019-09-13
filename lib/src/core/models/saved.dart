import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';
import 'package:jobber/src/core/models/position.dart';

import 'package:provider/provider.dart';
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

  void toggleSaved(BuildContext context) async {
    if (_prefsInstance == null) await _getInstance();
    final savedPositions = _prefsInstance.getStringList('savedPositions') ?? [];
    final model = Provider.of<Position>(context).toMap();
    if (await _saved()) {
      int matchIndex;
      for (int index = 0; index < savedPositions.length; index++) {
        try {
          final decoded = json.decode(savedPositions[index]);
          if (decoded['id'] == model['id']) {
            matchIndex = index;
            break;
          }
        } catch(e) {
          matchIndex = null;
        }
      }
      savedPositions.removeAt(matchIndex);
    } else {
      savedPositions.add(json.encode(model));
    }
    _prefsInstance.setStringList('savedPositions', savedPositions);
    Provider.of<Positions>(context).getPositions(context);

    saved = !saved;
    notifyListeners();
  }

  Future<bool> _saved() async {
    if (_prefsInstance == null) await _getInstance();
    final savedPositions = _prefsInstance.getStringList('savedPositions') ?? [];
    bool saved = false;
    for (String position in savedPositions) {
      try {
        final decoded = json.decode(position);
        if (decoded['id'] == positionId) {
          saved = true;
          break;
        }
      } catch(e) {
        saved = false;
      }
    }
    return saved;
  }

  Future<void> _getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    _prefsInstance = prefs;
  }
}
