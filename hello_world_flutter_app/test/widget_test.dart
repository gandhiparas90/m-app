import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_world_flutter_app/main.dart';

void main() {
  testWidgets('navigates to notes screen and updates note text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudyBuddyApp());

    expect(find.text('Welcome to Study Buddy'), findsOneWidget);
    expect(find.text('Go to Notes'), findsOneWidget);

    await tester.tap(find.text('Go to Notes'));
    await tester.pumpAndSettle();

    expect(find.text('Study Notes'), findsOneWidget);
    expect(find.text('No study note has been added yet.'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField),
      'Review stateless and stateful widgets',
    );
    await tester.tap(find.text('Save Note'));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('currentNoteText'))).data,
      'Review stateless and stateful widgets',
    );
  });

  testWidgets('clear note resets the displayed note', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const StudyBuddyApp());

    await tester.tap(find.text('Go to Notes'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Practice Flutter UI');
    await tester.tap(find.text('Save Note'));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('currentNoteText'))).data,
      'Practice Flutter UI',
    );

    await tester.tap(find.text('Clear Note'));
    await tester.pump();

    expect(find.text('No study note has been added yet.'), findsOneWidget);
  });
}
