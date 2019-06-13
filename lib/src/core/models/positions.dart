import 'package:flutter_jobs/src/core/resources/jobs_provider.dart';

class Positions {
  final _provider = JobsProvider();

  List<dynamic> _positions = [];

  List<dynamic> get positions => _positions;

  Future<void> getPositions() async {
    final positions = await _provider.positions();
    _positions = positions;
  }
}