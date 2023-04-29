import 'package:casino_test/presentation/ui/exception_indicators/exception_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExceptionIndicator', () {
    testWidgets('displays title and icon without message and button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExceptionIndicator(
              title: 'Test Title',
              icon: Icons.error,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('An error occurred. \nPlease try again later.'),
          findsNothing);
      expect(find.text('Try Again'), findsNothing);
    });

    testWidgets('displays title, icon, and message without button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExceptionIndicator(
              title: 'Test Title',
              icon: Icons.error,
              message: 'Test Message',
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
      expect(find.text('Try Again'), findsNothing);
    });

    testWidgets('displays title, icon, and button without message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExceptionIndicator(
              title: 'Test Title',
              icon: Icons.error,
              onTryAgain: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('An error occurred. \nPlease try again later.'),
          findsNothing);
      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('displays title, icon, message, and button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExceptionIndicator(
              title: 'Test Title',
              icon: Icons.error,
              message: 'Test Message',
              onTryAgain: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    });
  });
}
