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
  Map<String, List<GlobalKey>> _keys = {
    'positions': [],
    'saved': [],
  };

  bool get isLoading => _isLoading;

  List<dynamic> get positions => List.unmodifiable(_positions);

  List<dynamic> get saved => List.unmodifiable(_saved);

  Map<String, List<GlobalKey>> get keys => Map.unmodifiable(_keys);

  Future<void> getPositions(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _positions = await _provider.positionsFromLocation(context);
      _keys['positions'] = List.generate(_positions.length, (_) => GlobalKey());
    } catch (e) {
      print('Failed to get positions from location: $e');
      _positions = [];
    }

    _saved = await _provider.savedPositions();
    _keys['saved'] = List.generate(_saved.length, (_) => GlobalKey());

    _isLoading = false;
    notifyListeners();
  }
}
