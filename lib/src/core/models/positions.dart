import 'package:flutter/material.dart';

import 'package:jobber/src/core/resources/jobs_provider.dart';

class Positions with ChangeNotifier {
  Positions(BuildContext context) {
    getPositions(context);
  }

  final _provider = JobsProvider();

  final savedListKey = GlobalKey<AnimatedListState>();
  bool _isLoading = false;
  List<dynamic> _positions;
  List<dynamic> _saved;

  bool get isLoading => _isLoading;

  List<dynamic> get positions => _positions;

  List<dynamic> get saved => _saved;

  Future<void> getPositions(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _positions = await _provider.positionsFromLocation(context);
    } catch(e) {
      print('Failed to get positions from location: $e');
      _positions = [];
    }

    _saved = await _provider.savedPositions();

    _isLoading = false;
    notifyListeners();
  }
}
