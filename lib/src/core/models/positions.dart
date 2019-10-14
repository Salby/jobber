import 'package:flutter/material.dart';

import 'package:jobber/src/core/services/location_service.dart';
import 'package:jobber/src/core/resources/jobs_provider.dart';

class Positions with ChangeNotifier {
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

  /// Fetches positions from jobs.github.com.
  ///
  /// If [location] isn't null the positions will be fetched based on the
  /// user's location.
  Future<void> getPositions({UserLocation location}) async {
    _isLoading = true;
    notifyListeners();

    if (location != null) {
      try {
        _positions = await _provider.positionsFromLocation(location);
        _keys['positions'] =
            List.generate(_positions.length, (_) => GlobalKey());
      } catch (e) {
        print('Failed to get positions from location: $e');
        _positions = [];
      }
    } else {
      try {
        _positions = await _provider.positions();
        _keys['positions'] =
            List.generate(_positions.length, (_) => GlobalKey());
      } catch (e) {
        print('Failed to get positions');
        _positions = [];
      }
    }

    _saved = await _provider.savedPositions();
    _keys['saved'] = List.generate(_saved.length, (_) => GlobalKey());

    _isLoading = false;
    notifyListeners();
  }
}
