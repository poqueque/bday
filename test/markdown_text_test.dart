// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bday/ui/widgets/MarkdownText.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MarkdownText widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MarkdownText("This is test [with a first link](http://flutter.dev) and [with a second link](http://pub.dev)"));
    expect(find.text('This is test '), findsOneWidget);
    expect(find.text('with a link'), findsOneWidget);
  });
}
