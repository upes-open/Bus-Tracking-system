import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Text widget displays correct text', (WidgetTester tester) async {
    // Build the widget to be tested
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Hello, World!'),
        ),
      ),
    );

    // Perform the test assertions
    expect(find.text('Hello, World!'), findsOneWidget);
  });
}
