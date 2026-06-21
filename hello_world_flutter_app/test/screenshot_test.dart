import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_world_flutter_app/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> loadScreenshotFonts() async {
    final arial = File('/System/Library/Fonts/Supplemental/Arial.ttf');
    final arialBold = File('/System/Library/Fonts/Supplemental/Arial Bold.ttf');
    final materialIcons = File(
      '/Users/parasgandhi/Project/temp/flutter/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
    );

    final arialLoader = FontLoader('Arial')
      ..addFont(
        Future<ByteData>.value(
          ByteData.view((await arial.readAsBytes()).buffer),
        ),
      )
      ..addFont(
        Future<ByteData>.value(
          ByteData.view((await arialBold.readAsBytes()).buffer),
        ),
      );
    final iconLoader = FontLoader('MaterialIcons')
      ..addFont(
        Future<ByteData>.value(
          ByteData.view((await materialIcons.readAsBytes()).buffer),
        ),
      );

    await Future.wait([arialLoader.load(), iconLoader.load()]);
  }

  setUpAll(loadScreenshotFonts);

  Future<void> setMobileSurface(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
  }

  testWidgets('captures home screen screenshot', (WidgetTester tester) async {
    await setMobileSurface(tester);
    await tester.pumpWidget(const StudyBuddyApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(StudyBuddyApp),
      matchesGoldenFile('../screenshots/study_buddy_home.png'),
    );
  });

  testWidgets('captures empty notes screen screenshot', (
    WidgetTester tester,
  ) async {
    await setMobileSurface(tester);
    await tester.pumpWidget(const StudyBuddyApp());
    await tester.tap(find.text('Go to Notes'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(StudyBuddyApp),
      matchesGoldenFile('../screenshots/study_buddy_notes_empty.png'),
    );
  });

  testWidgets('captures saved note screen screenshot', (
    WidgetTester tester,
  ) async {
    await setMobileSurface(tester);
    await tester.pumpWidget(const StudyBuddyApp());
    await tester.tap(find.text('Go to Notes'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      'Review stateless and stateful widgets',
    );
    await tester.tap(find.text('Save Note'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(StudyBuddyApp),
      matchesGoldenFile('../screenshots/study_buddy_notes_saved.png'),
    );
  });

  testWidgets('captures cleared note screen screenshot', (
    WidgetTester tester,
  ) async {
    await setMobileSurface(tester);
    await tester.pumpWidget(const StudyBuddyApp());
    await tester.tap(find.text('Go to Notes'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Practice Flutter UI');
    await tester.tap(find.text('Save Note'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear Note'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(StudyBuddyApp),
      matchesGoldenFile('../screenshots/study_buddy_notes_cleared.png'),
    );
  });
}
