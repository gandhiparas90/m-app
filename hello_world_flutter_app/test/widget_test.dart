import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_world_flutter_app/main.dart';

void main() {
  Future<void> openGestureLab(WidgetTester tester) async {
    await tester.pumpWidget(const GestureLabApp());
    await tester.tap(find.text('Open Gesture Lab'));
    await tester.pumpAndSettle();
  }

  String statusText(WidgetTester tester) {
    return tester
        .widget<Text>(find.byKey(const Key('gestureStatusText')))
        .data!;
  }

  testWidgets('opens the gesture lab from the home screen', (
    WidgetTester tester,
  ) async {
    await openGestureLab(tester);

    expect(find.text('Gesture Lab'), findsOneWidget);
    expect(find.text('Try the Gestures'), findsOneWidget);
    expect(find.text('Tap Practice'), findsOneWidget);
  });

  testWidgets('tap changes the visible status text', (
    WidgetTester tester,
  ) async {
    await openGestureLab(tester);

    await tester.tap(find.byKey(const Key('gestureCard')));
    await tester.pumpAndSettle();

    expect(statusText(tester), 'Tap detected: color changed 1 time.');
  });

  testWidgets('long press toggles focus mode feedback', (
    WidgetTester tester,
  ) async {
    await openGestureLab(tester);

    await tester.longPress(find.byKey(const Key('gestureCard')));
    await tester.pump();

    expect(statusText(tester), 'Long press detected: focus mode is on.');
    expect(find.text('Focus mode turned on'), findsOneWidget);
  });

  testWidgets('horizontal swipe moves to the next gesture card', (
    WidgetTester tester,
  ) async {
    await openGestureLab(tester);

    await tester.fling(
      find.byKey(const Key('gestureCard')),
      const Offset(-300, 0),
      900,
    );
    await tester.pumpAndSettle();

    expect(find.text('Swipe Practice'), findsOneWidget);
    expect(statusText(tester), 'Swipe left detected: moved to Swipe Practice.');
  });

  testWidgets('reset returns the screen to the initial gesture state', (
    WidgetTester tester,
  ) async {
    await openGestureLab(tester);
    await tester.tap(find.byKey(const Key('gestureCard')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Reset Gestures'));
    await tester.pumpAndSettle();

    expect(find.text('Tap Practice'), findsOneWidget);
    expect(statusText(tester), 'Ready: tap, long press, or swipe the card.');
  });
}
