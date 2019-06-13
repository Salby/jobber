import 'dart:convert';

import 'package:http/http.dart' show Client;

class JobsProvider {
  final _client = Client();
  final _baseUrl = 'https://jobs.github.com';

  Future<List<dynamic>> positions() async {
    final response = await _client.get('$_baseUrl/positions.json');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to get positions';
    }
  }
}