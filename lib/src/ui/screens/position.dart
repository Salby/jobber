import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/positions.dart';

import 'package:provider/provider.dart';

class Position extends StatelessWidget {
  Position({
    this.title,
    this.id,
  });

  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Position'),
      ),
    );
  }
}
