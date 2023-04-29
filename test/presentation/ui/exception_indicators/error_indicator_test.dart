import 'dart:io';

import 'package:casino_test/presentation/ui/exception_indicators/error_indicator.dart';
import 'package:casino_test/presentation/ui/exception_indicators/generic_error_indicator.dart';
import 'package:casino_test/presentation/ui/exception_indicators/no_connection_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorIndicator', () {
    testWidgets('displays NoConnectionIndicator when error is SocketException',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorIndicator(
              error: const SocketException(''),
              onTryAgain: () {},
            ),
          ),
        ),
      );

      expect(find.byType(NoConnectionIndicator), findsOneWidget);
    });

    testWidgets(
        'displays GenericErrorIndicator when error is not SocketException',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorIndicator(
              error: Exception('Generic error'),
              onTryAgain: () {},
            ),
          ),
        ),
      );

      expect(find.byType(GenericErrorIndicator), findsOneWidget);
    });
  });
}
