// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animia/UI/searchEngine.dart';

void main() {
  testWidgets('SearchAnime widget test', (WidgetTester tester) async {
    // Build the SearchAnime widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: SearchEngine()));

    // Verify that the search field is present.
    expect(find.byType(TextField), findsOneWidget);

    // Enter a search query and trigger a search.
    await tester.enterText(find.byType(TextField), 'Naruto');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // Verify that the search results are displayed.
    expect(find.text('Naruto'), findsWidgets);
  });
}