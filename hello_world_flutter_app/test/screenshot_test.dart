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

  Future<void> openGestureLab(WidgetTester tester) async {
    await tester.pumpWidget(const GestureLabApp());
    await tester.tap(find.text('Open Gesture Lab'));
    await tester.pumpAndSettle();
  }

  testWidgets('captures gesture home screen screenshot', (
    WidgetTester tester,
  ) async {
    await setMobileSurface(tester);
    await tester.pumpWidget(const GestureLabApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GestureLabApp),
      matchesGoldenFile('../screenshots/gesture_lab_home.png'),
    );
  });

  testWidgets('captures initial gesture screen screenshot', (
    WidgetTester tester,
  ) async {
    await setMobileSurface(tester);
    await openGestureLab(tester);

    await expectLater(
      find.byType(GestureLabApp),
      matchesGoldenFile('../screenshots/gesture_lab_initial.png'),
    );
  });

  testWidgets('captures tap gesture screenshot', (WidgetTester tester) async {
    await setMobileSurface(tester);
    await openGestureLab(tester);
    await tester.tap(find.byKey(const Key('gestureCard')));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GestureLabApp),
      matchesGoldenFile('../screenshots/gesture_lab_tap.png'),
    );
  });

  testWidgets('captures long press gesture screenshot', (
    WidgetTester tester,
  ) async {
    await setMobileSurface(tester);
    await openGestureLab(tester);
    await tester.longPress(find.byKey(const Key('gestureCard')));
    await tester.pump();

    await expectLater(
      find.byType(GestureLabApp),
      matchesGoldenFile('../screenshots/gesture_lab_long_press.png'),
    );
  });

  testWidgets('captures swipe gesture screenshot', (WidgetTester tester) async {
    await setMobileSurface(tester);
    await openGestureLab(tester);
    await tester.fling(
      find.byKey(const Key('gestureCard')),
      const Offset(-300, 0),
      900,
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(GestureLabApp),
      matchesGoldenFile('../screenshots/gesture_lab_swipe.png'),
    );
  });
}
