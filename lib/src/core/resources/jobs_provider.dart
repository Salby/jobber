import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:jobber/src/core/services/location_service.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart';

class JobsProvider {
  final _client = Client();
  final _baseUrl = 'https://jobs.github.com';

  Future<List<dynamic>> positionsFromLocation(BuildContext context) async {
    final location = Provider.of<UserLocation>(context);
    Response response;
    if (location != null) {
      final lat = Uri.encodeComponent(location.latitude.toString());
      final long = Uri.encodeComponent(location.longitude.toString());
      response = await _client.get(
        '$_baseUrl/positions.json?lat=$lat&long=$long',
      );
    } else {
      response = await _client.get('$_baseUrl/positions.json');
    }
    return _handleResponse(response);
  }

  List<dynamic> _handleResponse(Response response, { String error }) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw error ?? 'Failed to get positions';
    }
  }
}
