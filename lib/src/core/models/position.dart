import 'package:flutter/material.dart';

import 'package:jobber/src/core/resources/jobs_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Position with ChangeNotifier {
  Position(this.id);

  final String id;

  bool isLoading = false;
  String type = '';
  String url = '';
  String createdAt = '';
  String company = '';
  String companyUrl = '';
  String location = '';
  String title = '';
  String description = '';
  String howToApply = '';
  String companyLogo = '';

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
    companyLogo = positionData['company_logo'];
    isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'url': url,
    'created_at': createdAt,
    'company': company,
    'company_url': companyUrl,
    'location': location,
    'title': title,
    'description': description,
    'how_to_apply': howToApply,
    'companyLogo': companyLogo,
  };
}
