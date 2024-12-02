import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:social_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Provide a widget to the MyApp constructor
    await tester.pumpWidget(MyApp(widget: Scaffold(
      appBar: AppBar(
        title: Text('Counter Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('0', key: Key('counter')),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // logic to increment counter should be here
              },
            ),
          ],
        ),
      ),
    )));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
