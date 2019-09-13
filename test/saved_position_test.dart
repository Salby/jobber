import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/position.dart';
import 'package:jobber/src/ui/components/saved_position.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  Position position;

  setUp(() {
    // Create a dummy position to test against.
    position = Position(
      id: '123',
      title: 'Cross-platform mobile app developer',
      description: 'We are looking for an experienced developer interested in working with mobile apps built with Flutter.',
      location: 'Copenhagen',
    );
  });

  /// Builds a [SavedPosition] widget with [tester].
  Future<void> _buildTile(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SavedPosition(
            position: position,
            parentKey: GlobalKey(),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('SavedPosition displays data correctly', (WidgetTester tester) async {
    // Build tile.
    await _buildTile(tester);

    // Expect to find 2 [Text] widgets, each containing the position title and
    // location respectively.
    expect(find.text(position.title), findsOneWidget);
    expect(find.text(position.location), findsOneWidget);
  });
}
