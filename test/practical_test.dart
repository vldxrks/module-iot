import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_control_1/main.dart';
import 'package:module_control_1/rating_badge.dart';

void main() {
  for (final entry in <double, Color>{
    0: Colors.red,
    2.49: Colors.red,
    2.5: Colors.orange,
    3.99: Colors.orange,
    4: Colors.green,
    5: Colors.green,
  }.entries) {
    testWidgets('Колір для rating=${entry.key}', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RatingBadge(rating: entry.key),
      ));
      final icon = tester.widget<Icon>(find.byIcon(Icons.star));
      expect(icon.color, entry.value);
      expect(find.text(entry.key.toStringAsFixed(1)), findsOneWidget);
    });
  }
  testWidgets('Округлення й необов’язковий підпис', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RatingBadge(rating: 4.76, label: 'Відмінно'),
    ));
    expect(find.text('4.8'), findsOneWidget);
    expect(find.text('Відмінно'), findsOneWidget);
    await tester.pumpWidget(const MaterialApp(home: RatingBadge(rating: 1.2)));
    expect(find.text('Відмінно'), findsNothing);
    expect(find.byType(Text), findsOneWidget);
  });
  test('Некоректні рейтинги відхиляються', () {
    for (final rating in [-0.1, 5.1, double.nan, double.infinity]) {
      expect(() => RatingBadge(rating: rating), throwsAssertionError);
    }
  });
  testWidgets('Навігація зберігає стан і передає актуальне значення',
      (tester) async {
    await tester.pumpWidget(const ModuleControlApp());
    expect(find.text('Лічильник: 0'), findsOneWidget);
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('+1'));
      await tester.pump();
    }
    await tester.tap(find.text('Детальніше'));
    await tester.pumpAndSettle();
    expect(find.text('Передане значення: 3'), findsOneWidget);
    await tester.tap(find.text('Назад'));
    await tester.pumpAndSettle();
    expect(find.text('Лічильник: 3'), findsOneWidget);
    await tester.tap(find.text('+1'));
    await tester.pump();
    await tester.tap(find.text('Детальніше'));
    await tester.pumpAndSettle();
    expect(find.text('Передане значення: 4'), findsOneWidget);
  });
}
