import 'package:flutter/material.dart';

import 'package:jobber/src/core/resources/jobs_provider.dart';

class Positions with ChangeNotifier {
  final _provider = JobsProvider();

  bool isLoading = false;
  List<dynamic> _positions;
  List<dynamic> _saved;

  List<dynamic> get positions => _positions;
  List<dynamic> get saved => _saved;

  Future<void> getPositions(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    _positions = await _provider.positionsFromLocation(context);
    _saved = await _provider.savedPositions();
    isLoading = false;
    notifyListeners();
  }
}