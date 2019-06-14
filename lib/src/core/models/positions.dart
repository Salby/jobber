import 'package:flutter/material.dart';

import 'package:jobber/src/core/resources/jobs_provider.dart';

class Positions with ChangeNotifier {
  final _provider = JobsProvider();

  bool isLoading = false;
  List<dynamic> _positions;

  List<dynamic> get positions => _positions;

  Future<void> getPositions(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final positions = await _provider.positionsFromLocation(context);
    _positions = positions;
    isLoading = false;
    notifyListeners();
  }
}