import 'package:flutter_test/flutter_test.dart';

import 'package:hello_world_flutter_app/main.dart';

void main() {
  testWidgets('shows the Hello World message', (WidgetTester tester) async {
    await tester.pumpWidget(const HelloWorldApp());

    expect(find.text('Flutter Lab'), findsOneWidget);
    expect(find.text('Hello World'), findsOneWidget);
  });
}
