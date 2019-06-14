import 'package:flutter/material.dart';

import 'package:jobber/src/core/resources/jobs_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Position with ChangeNotifier {
  Position(this.id) {
    _getInstance();
  }

  final String id;

  bool isLoading = false;
  SharedPreferences _prefsInstance;
  String type;
  String url;
  String createdAt;
  String company;
  String companyUrl;
  String location;
  String title;
  String description;
  String howToApply;
  String companyLogo;
  bool saved;

  final _provider = JobsProvider();

  Future<void> getPosition() async {
    isLoading = true;
    notifyListeners();
    final positionData = await _provider.positionFromId(id);
    type = positionData['type'];
    url = positionData['url'];
    createdAt = positionData['created_at'];
    company = positionData['company'];
    companyUrl = positionData['company_url'];
    location = positionData['location'];
    title = positionData['title'];
    description = positionData['description'];
    howToApply = positionData['how_to_apply'];
    companyLogo = positionData['companyLogo'];
    saved = await _saved();
    isLoading = false;
    notifyListeners();
  }

  void toggleSaved() async {
    if (_prefsInstance == null) await _getInstance();
    final savedPositions = _prefsInstance.getStringList('savedPositions') ?? [];
    if (savedPositions.contains(id)) {
      savedPositions.remove(id);
    } else {
      savedPositions.add(id);
      _prefsInstance.setStringList('savedPositions', savedPositions);
    }
    saved = !saved;
    notifyListeners();
  }

  Future<void> _getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    _prefsInstance = prefs;
  }

  Future<bool> _saved() async {
    if (_prefsInstance == null) await _getInstance();
    final savedPositions = _prefsInstance.getStringList('savedPositions') ?? [];
    return savedPositions.contains(id);
  }
}
